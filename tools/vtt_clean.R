# Turn a Zoom .vtt transcript into compact "Speaker: text" lines for an LLM.
# Drops the WEBVTT header, cue numbers, and timestamps; merges consecutive
# cues from the same speaker into one line. Older auto-caption files have no
# speaker labels — their lines are kept as-is under an empty speaker.

vtt_to_transcript <- function(vtt_path) {
  raw <- readLines(vtt_path, warn = FALSE, encoding = "UTF-8")
  raw <- trimws(raw)
  keep <- raw != "" & raw != "WEBVTT" &
    !grepl("^\\d+$", raw) &
    !grepl("^\\d{2}:\\d{2}:\\d{2}\\.\\d{3} -->", raw)
  lines <- raw[keep]

  has_speaker <- grepl("^[^:]{1,30}: ", lines)
  speaker <- ifelse(has_speaker, sub(":.*$", "", lines), "")
  text    <- ifelse(has_speaker, sub("^[^:]{1,30}: ", "", lines), lines)

  # Merge runs of the same speaker
  run_id <- cumsum(c(TRUE, speaker[-1] != speaker[-length(speaker)]))
  merged_text    <- tapply(text, run_id, paste, collapse = " ")
  merged_speaker <- tapply(speaker, run_id, `[`, 1)

  out <- ifelse(merged_speaker == "", merged_text,
                paste0(merged_speaker, ": ", merged_text))
  paste(out, collapse = "\n")
}
