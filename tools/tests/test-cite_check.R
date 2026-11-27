cues <- function() parse_vtt(readLines(fixture("youtube_s2e33_head.vtt"), warn = FALSE))

check <- function(...) check_citations(c(...), cues(), episode = "s02e33")

test_that("a verbatim quote cited near its cue passes", {
  out <- check('- *"Lumi\'s healing magic slid off like oil."* [VTT 00:00:46]')
  expect_identical(out$status, "ok")
})

test_that("a quote spanning two cues is found", {
  out <- check('- *"the ugly red marks blooming on the skins of our captain"* [VTT 00:00:35]')
  expect_identical(out$status, "ok")
})

test_that("case, punctuation and curly quotes are ignored", {
  out <- check("- *\"DISPEL MAGIC -- did nothing’\"* [VTT 00:00:52]")
  expect_identical(out$status, "ok")
})

test_that("a quote cited more than 30 s from its cue is off", {
  out <- check('- *"Dispel magic did nothing."* [VTT 00:01:40]')
  expect_identical(out$status, "off")
  expect_match(out$found_at, "00:00:49")
})

test_that("a range citation covers quotes inside it", {
  out <- check('- *"slid off like oil"* and *"modrons who calmly"* [VTT 00:00:40–00:01:10]')
  expect_identical(out$status, c("ok", "ok"))
})

test_that("a quote that is not in the transcript is missing", {
  out <- check('- *"the slaad laughed at the captain"* [VTT 00:00:30]')
  expect_identical(out$status, "missing")
})

test_that("a near-verbatim quote is flagged, not passed", {
  out <- check('- *"Lumi\'s healing spells slid off like oil."* [VTT 00:00:46]')
  expect_identical(out$status, "near")
})

test_that("[ __ ] stays a literal and an ellipsis splits a quote", {
  out <- check('- *"Then red went down ... by the blue."* [VTT 00:00:30]')
  expect_identical(out$status, "ok")
})

test_that("prose quotes with no citation only need to exist", {
  out <- check('The crew learn the truth. *"Dispel magic did nothing."* Find out!')
  expect_identical(out$status, "ok")
  out <- check('The crew learn the truth. *"Nothing at all happened."* Find out!')
  expect_identical(out$status, "missing")
})

test_that("frontmatter, Recap citations and other episodes are skipped", {
  out <- check('---', 'title: "Dispel"', '---',
               '- *"not checked"* [Recap 00:00:03]',
               '- *"also not checked"* [VTT s02e34 00:00:03]')
  expect_identical(nrow(out), 0L)
})

test_that("a censored word matches even with non-breaking spaces in the caption", {
  cues <- data.frame(start = 5, speaker = "", text = "A [ __ ] bro. Captain.",
                     stringsAsFactors = FALSE)
  out <- check_citations('- *"A [ __ ] bro. Captain."* [VTT 00:00:05]', cues, "s02e24")
  expect_identical(out$status, "ok")
})

test_that("each quote is checked against the first citation after it", {
  out <- check('- (*"not ours"* [VTT s02e34 00:00:43]); *"Dispel magic did nothing."* [VTT 00:00:50]')
  expect_identical(out$quote, "Dispel magic did nothing.")
  expect_identical(out$status, "ok")
  out <- check('- *"slid off like oil"* [VTT 00:00:46] then *"modrons who calmly"* [VTT 00:01:07]')
  expect_identical(out$status, c("ok", "ok"))
  out <- check('- *"Dispel magic did nothing."* [VTT 00:03:00] and *"slid off like oil"* [VTT 00:00:46]')
  expect_identical(out$status, c("off", "ok"))
})
