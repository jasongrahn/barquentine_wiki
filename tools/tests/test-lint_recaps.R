names_md <- c(
  "| slug | canonical | type | transcript variants | first seen |",
  "|---|---|---|---|---|",
  "| mira | Mira | npc | | s03e02 |",
  "| eberron | Eberron | place | | s03e02 |",
  "| victorias_chest | Victoria's chest | item | | s03e03 |"
)
threads_md <- c(
  "## T-007 · Mira", "status: open",
  "- s03e02 — an old woman", "- s03e06 — a dragon",
  "## T-008 · Victoria's chest", "status: open",
  "- s03e03 — the chest"
)

# A valid s03e06 recap; `...` replaces frontmatter lines by key.
recap <- function(...) {
  fm <- list(
    episode = "s03e06", title = '"It Really Ties It Together"',
    recorded = "2026-11-03", source = "GMT20261104-021831_Recording.transcript.vtt",
    source_tier = "zoom", recap_prose = "generated", arc = "~",
    npcs = "[mira]", places = "[eberron]", items = "[victorias_chest]",
    threads_opened = "[]", threads_advanced = "[T-007]", threads_closed = "[]",
    callbacks = "[s03e02]"
  )
  fm <- modifyList(fm, list(...))
  fm <- Filter(Negate(is.null), fm)
  c("---", paste0(names(fm), ": ", unlist(fm)), "---", "",
    "# It Really Ties It Together", "", "Prose.")
}

expect_problem <- function(problems, pattern) {
  expect_match(problems, pattern, all = FALSE)
}

lint <- function(text, file = "s03e06.md") {
  lint_recap(text, file, read_names(names_md), read_threads(threads_md))
}

test_that("a valid recap has no problems", {
  expect_identical(lint(recap()), character())
})

test_that("a file without frontmatter is a problem", {
  expect_problem(lint(c("# Title", "", "Prose.")), "no frontmatter")
})

test_that("missing keys are named", {
  expect_problem(lint(recap(arc = NULL)), "missing key: arc")
})

test_that("episode must match the filename", {
  expect_problem(lint(recap(episode = "s03e05")), "episode s03e05 does not match file")
  expect_problem(lint(recap(episode = "S3E6"), "S3E6.md"), "episode S3E6 is not sXXeYY")
})

test_that("title must equal the H1", {
  expect_problem(lint(recap(title = '"Another Title"')), "title does not match H1")
})

test_that("source_tier, recorded and recap_prose are validated", {
  expect_problem(lint(recap(source_tier = "vimeo")), "source_tier")
  expect_problem(lint(recap(recorded = "Nov 3")), "recorded")
  expect_problem(lint(recap(recap_prose = "dm")), "recap_prose")
  expect_identical(lint(recap(recap_prose = "dm_intro s3e7")), character())
})

test_that("slugs must exist in names.md with the matching type", {
  expect_problem(lint(recap(npcs = "[mira, gloria]")), "npcs: unknown slug gloria")
  expect_problem(lint(recap(places = "[mira]")), "places: mira is a npc")
})

test_that("thread ids must exist and cite this episode", {
  expect_problem(lint(recap(threads_opened = "[T-099]")), "unknown thread T-099")
  expect_problem(lint(recap(threads_closed = "[T-008]")), "T-008 does not cite s03e06")
})

test_that("callbacks must be earlier episode ids", {
  expect_problem(lint(recap(callbacks = "[s03e07]")), "callback s03e07 is not earlier")
  expect_problem(lint(recap(callbacks = "[S2E15]")), "callback S2E15 is not sXXeYY")
  expect_identical(lint(recap(callbacks = "[s02e15, s03e05]")), character())
})

test_that("keys match exactly, not by prefix", {
  text <- recap(episode = NULL)
  text <- append(text, "episode_title: x", after = 1)
  problems <- lint(text)
  expect_problem(problems, "missing key: episode")
  expect_false(any(grepl("not sXXeYY", problems)))
})

test_that("the H1 is read after the frontmatter, not from YAML comments", {
  expect_identical(lint(append(recap(), "# a comment", after = 1)), character())
})

test_that("malformed YAML is reported, not thrown", {
  expect_problem(lint(append(recap(), "title: It: Really", after = 1)), "invalid frontmatter")
})

test_that("bullets under a non-thread heading are not citations", {
  t <- read_threads(c(threads_md, "## Retired ideas", "- s03e06 — nope"))
  expect_false("s03e06" %in% t[["T-008"]])
})

test_that("names.md header and separator rows of any table are skipped", {
  n <- read_names(c(names_md, "", "| type | meaning |", "|---|---|", "| npc | a person |"))
  expect_false(any(n$slug %in% c("slug", "---", "type")))
})
