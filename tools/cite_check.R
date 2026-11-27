# Check a recap's italic quotes and [VTT hh:mm:ss] citations against the
# raw .vtt. Pure functions take text; the CLI at the bottom reads files.
# Rscript --vanilla tools/cite_check.R BarquentineWiki/sessions/s02e25.md <raw.vtt>
# Statuses: ok, near (close but not verbatim), off (verbatim but more than
# `tolerance` s from every citation on its line), missing.

# Lowercase words with punctuation and apostrophes dropped; "[ __ ]" kept.
norm_words <- function(x) {
  x <- tolower(x)
  x <- gsub("\\[[[:space:]\u00a0]*__[[:space:]\u00a0]*\\]", " censoredword ", x)
  x <- gsub("[‘’']", "", x)
  x <- gsub("[^a-z0-9 ]", " ", x)
  x <- trimws(gsub("\\s+", " ", x))
  if (x == "") character() else strsplit(x, " ")[[1]]
}

# One row per spoken word, with the start time of its cue.
word_stream <- function(cues) {
  w <- lapply(cues$text, norm_words)
  list(word = unlist(w), start = rep(cues$start, lengths(w)))
}

# Share of words matching position by position, for every window.
phrase_scores <- function(words, stream) {
  n <- length(words); N <- length(stream$word)
  if (!n || N < n) return(numeric())
  idx <- seq_len(N - n + 1)
  hits <- vapply(seq_len(n), function(k) stream$word[idx + k - 1] == words[k],
                 logical(length(idx)))
  rowSums(matrix(hits, nrow = length(idx))) / n
}

to_secs <- function(t) {
  p <- as.numeric(strsplit(t, ":")[[1]])
  sum(p * c(3600, 60, 1))
}
fmt_secs <- function(s) {
  sprintf("%02d:%02d:%02d", s %/% 3600, s %% 3600 %/% 60, floor(s %% 60))
}

# [VTT a] or [VTT a–b] citations for this episode on one line, as ranges.
own_cites <- function(line, episode) {
  m <- regmatches(line, gregexpr(
    "\\[VTT (s\\d{2}e\\d{2} )?\\d{2}:\\d{2}:\\d{2}([–-]\\d{2}:\\d{2}:\\d{2})?\\]",
    line, perl = TRUE))[[1]]
  ep <- sub("^\\[VTT (s\\d{2}e\\d{2}) .*", "\\1", m)
  m <- m[!grepl("^\\[VTT s\\d{2}e\\d{2} ", m) | ep == episode]
  times <- regmatches(m, gregexpr("\\d{2}:\\d{2}:\\d{2}", m))
  lapply(times, function(t) c(to_secs(t[1]), to_secs(t[length(t)])))
}

check_quote <- function(quote, cites, stream, tolerance) {
  segments <- Filter(length, lapply(strsplit(quote, "\\.\\.\\.|…")[[1]], norm_words))
  times <- character(); status <- "ok"
  for (words in segments) {
    score <- phrase_scores(words, stream)
    exact <- stream$start[which(score == 1)]
    if (!length(exact)) {
      best <- if (length(score)) max(score) else 0
      near_at <- stream$start[which.max(score)]
      return(list(status = if (best >= 0.75) "near" else "missing",
                  found_at = if (best >= 0.75) fmt_secs(near_at) else ""))
    }
    in_range <- vapply(exact, function(t) any(vapply(cites, function(r)
      t >= r[1] - tolerance && t <= r[2] + tolerance, logical(1))), logical(1))
    if (length(cites) && !any(in_range)) {
      status <- "off"
      times <- c(times, head(unique(fmt_secs(exact)), 3))
    }
  }
  list(status = status, found_at = paste(times, collapse = ", "))
}

# One row per checked quote: line, quote, cited, found_at, status.
check_citations <- function(text, cues, episode, tolerance = 30) {
  stream <- word_stream(cues)
  fm_end <- if (length(text) && text[1] == "---") match("---", text[-1]) + 1 else 0
  rows <- list()
  for (i in seq_along(text)) {
    if (i <= fm_end) next
    line <- text[i]
    qm <- gregexpr('\\*"(.*?)"\\*', line, perl = TRUE)[[1]]
    if (qm[1] == -1) next
    quotes <- regmatches(line, list(qm))[[1]]
    # A quote belongs to the first citation after it; with none after it,
    # to every citation on the line for this episode.
    cm <- gregexpr("\\[(VTT|Recap) [^]]*\\]", line, perl = TRUE)[[1]]
    cite_text <- if (cm[1] == -1) character() else regmatches(line, list(cm))[[1]]
    for (j in seq_along(quotes)) {
      after <- which(cm > qm[j])
      scope <- if (length(after)) cite_text[after[1]] else paste(cite_text, collapse = " ")
      cites <- own_cites(scope, episode)
      if (!length(cites) && length(cite_text)) next
      q <- substr(quotes[j], 3, nchar(quotes[j]) - 2)
      res <- check_quote(q, cites, stream, tolerance)
      cited <- paste(vapply(cites, function(r) fmt_secs(r[1]), ""), collapse = ", ")
      rows[[length(rows) + 1]] <- data.frame(line = i, quote = q, cited = cited,
        found_at = res$found_at, status = res$status, stringsAsFactors = FALSE)
    }
  }
  if (!length(rows)) {
    return(data.frame(line = integer(), quote = character(), cited = character(),
                      found_at = character(), status = character()))
  }
  do.call(rbind, rows)
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) != 2 || !all(file.exists(args))) {
    writeLines("usage: Rscript tools/cite_check.R <recap.md> <raw.vtt>")
    quit(status = 2)
  }
  here <- dirname(sub("^--file=", "", grep("^--file=", commandArgs(), value = TRUE)))
  source(file.path(here, "vtt_clean.R"))
  episode <- sub("\\.md$", "", basename(args[1]))
  out <- check_citations(readLines(args[1], warn = FALSE),
                         parse_vtt(readLines(args[2], warn = FALSE, encoding = "UTF-8")),
                         episode)
  bad <- out[out$status != "ok", ]
  for (k in seq_len(nrow(bad))) {
    writeLines(sprintf("line %d · %s · cited %s · found %s · \"%s\"", bad$line[k],
      bad$status[k], if (nzchar(bad$cited[k])) bad$cited[k] else "-",
      if (nzchar(bad$found_at[k])) bad$found_at[k] else "-", bad$quote[k]))
  }
  tab <- table(factor(out$status, c("ok", "near", "off", "missing")))
  writeLines(sprintf("%s: %d quotes · %d ok · %d near · %d off · %d missing",
    basename(args[1]), nrow(out), tab[["ok"]], tab[["near"]], tab[["off"]], tab[["missing"]]))
  quit(status = as.integer(tab[["off"]] + tab[["missing"]] > 0))
}
