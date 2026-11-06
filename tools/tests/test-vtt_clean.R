test_that("Zoom transcripts keep their merged 'Speaker: text' output", {
  expected <- paste(readLines(fixture("zoom_s2e34_head.expected.txt")), collapse = "\n")
  expect_identical(vtt_to_transcript(fixture("zoom_s2e34_head.vtt")), expected)
})

youtube_lines <- function() {
  strsplit(vtt_to_transcript(fixture("youtube_s2e33_head.vtt")), "\n")[[1]]
}

test_that("unlabelled transcripts become '[hh:mm:ss] text' blocks", {
  out <- youtube_lines()
  expect_gt(length(out), 1)
  expect_true(all(grepl("^\\[\\d{2}:\\d{2}:\\d{2}\\] \\S", out)))
  expect_match(out[1], "^\\[00:00:00\\] Things got real gross real fast aboard the Manticor\\.")
})

test_that("a new block starts once a minute has passed", {
  stamps <- sub("^\\[(.{8})\\].*", "\\1", youtube_lines())
  secs <- as.numeric(as.difftime(stamps, format = "%H:%M:%S", units = "secs"))
  expect_true(all(diff(secs) >= 60))
  expect_true(all(diff(secs) < 75))
})

test_that("mode overrides auto-detection", {
  out <- vtt_to_transcript(fixture("zoom_s2e34_head.vtt"), mode = "blocks")
  expect_match(out, "^\\[00:00:00\\] The Admiral: Okay\\.")
  out <- vtt_to_transcript(fixture("youtube_s2e33_head.vtt"), mode = "speakers")
  expect_false(grepl("\n", out))
})

vtt_lines <- function(...) {
  f <- tempfile(fileext = ".vtt")
  writeLines(c("WEBVTT", "", ...), f)
  f
}

test_that("a caption that is only a number is kept", {
  f <- vtt_lines("1", "00:00:01.000 --> 00:00:02.000", "roll it", "",
                 "2", "00:00:03.000 --> 00:00:04.000", "21", "")
  expect_identical(vtt_to_transcript(f), "[00:00:01] roll it 21")
})

test_that("a file with no cues gives empty output in every mode", {
  f <- vtt_lines()
  for (m in c("auto", "speakers", "blocks")) expect_identical(vtt_to_transcript(f, m), "")
})
