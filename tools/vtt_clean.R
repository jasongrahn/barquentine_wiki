# Turn a .vtt transcript into compact text lines for an LLM.
# Zoom files carry speaker labels: consecutive cues from the same speaker
# merge into one "Speaker: text" line, with no timestamps. YouTube
# auto-caption files have no speaker labels: cues are grouped into
# "[hh:mm:ss] text" blocks of about a minute so lines stay citable.

# Parse VTT lines into one row per cue: start (seconds), speaker, text.
parse_vtt <- function(lines) {
  lines <- trimws(lines)
  is_time <- grepl("^(\\d{2}:)?\\d{2}:\\d{2}\\.\\d{3} -->", lines)
  # A cue number is a bare integer directly above a timing line; a bare
  # integer anywhere else is spoken text (a dice roll, say).
  is_cue_num <- grepl("^\\d+$", lines) & c(is_time[-1], FALSE)
  is_text <- lines != "" & lines != "WEBVTT" & !is_cue_num & !is_time
  cue <- cumsum(is_time)
  keep <- is_text & cue > 0

  starts <- vapply(strsplit(sub(" -->.*", "", lines[is_time]), "[:.]"),
                   function(p) sum(as.numeric(p) * tail(c(3600, 60, 1, 0.001), length(p))),
                   numeric(1))
  text <- tapply(lines[keep], cue[keep], paste, collapse = " ")
  idx  <- as.integer(names(text))

  has_speaker <- grepl("^[^:]{1,30}: ", text)
  data.frame(
    start   = starts[idx],
    speaker = ifelse(has_speaker, sub(":.*$", "", text), ""),
    text    = ifelse(has_speaker, sub("^[^:]{1,30}: ", "", text), unname(text)),
    stringsAsFactors = FALSE
  )
}

# Merge runs of the same speaker into "Speaker: text" lines.
format_speaker_runs <- function(cues) {
  if (!nrow(cues)) return("")
  speaker <- cues$speaker
  run_id <- cumsum(c(TRUE, speaker[-1] != speaker[-length(speaker)]))
  merged_text    <- tapply(cues$text, run_id, paste, collapse = " ")
  merged_speaker <- tapply(speaker, run_id, `[`, 1)

  out <- ifelse(merged_speaker == "", merged_text,
                paste0(merged_speaker, ": ", merged_text))
  paste(out, collapse = "\n")
}

# Group cues into "[hh:mm:ss] text" blocks; a new block starts once a cue
# begins `secs` or more after the current block's first cue.
format_time_blocks <- function(cues, secs = 60) {
  if (!nrow(cues)) return("")
  block <- integer(nrow(cues))
  block_start <- -Inf
  for (i in seq_len(nrow(cues))) {
    new_block <- cues$start[i] - block_start >= secs
    if (new_block) block_start <- cues$start[i]
    block[i] <- (if (i == 1) 0L else block[i - 1]) + new_block
  }
  # Label a cue when its speaker differs from the previous cue or a block opens
  new_speaker <- cues$speaker != "" &
    (c(TRUE, cues$speaker[-1] != cues$speaker[-nrow(cues)]) | !duplicated(block))
  text  <- ifelse(new_speaker, paste0(cues$speaker, ": ", cues$text), cues$text)
  text  <- tapply(text, block, paste, collapse = " ")
  first <- tapply(cues$start, block, min)
  stamp <- sprintf("%02d:%02d:%02d", first %/% 3600, first %% 3600 %/% 60,
                   floor(first %% 60))
  paste0("[", stamp, "] ", text, collapse = "\n")
}

# mode: "auto" uses speaker runs when most cues carry a speaker label.
vtt_to_transcript <- function(vtt_path, mode = c("auto", "speakers", "blocks")) {
  mode <- match.arg(mode)
  cues <- parse_vtt(readLines(vtt_path, warn = FALSE, encoding = "UTF-8"))
  if (mode == "auto" && !nrow(cues)) return("")
  if (mode == "auto") {
    mode <- if (mean(cues$speaker != "") >= 0.5) "speakers" else "blocks"
  }
  if (mode == "speakers") format_speaker_runs(cues) else format_time_blocks(cues)
}
