# Lint recap frontmatter against the schema in recap_playbook.md, names.md
# and threads.md. Pure functions take file text; the CLI at the bottom
# reads files.
#   Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s03e*.md

required_keys <- c("episode", "title", "recorded", "source", "source_tier",
                   "recap_prose", "arc", "npcs", "places", "items",
                   "threads_opened", "threads_advanced", "threads_closed",
                   "callbacks")

# The "| slug | ..." table in names.md -> data frame of slug and type.
read_names <- function(text) {
  start <- grep("^\\|\\s*slug\\s*\\|", text)[1]
  rest <- text[-seq_len(start + 1)]  # drop the header and separator rows
  rows <- rest[seq_len(match(FALSE, grepl("^\\|", rest), nomatch = length(rest) + 1) - 1)]
  cells <- lapply(strsplit(rows, "|", fixed = TRUE), trimws)
  data.frame(slug = vapply(cells, `[`, "", 2),
             type = vapply(cells, `[`, "", 4),
             stringsAsFactors = FALSE)
}

# threads.md -> named list: thread id -> episodes it cites.
read_threads <- function(text) {
  id <- sub("^## (T-\\d{3}).*", "\\1", text)
  is_head <- grepl("^## T-\\d{3}", text)
  owner <- cumsum(is_head)
  # Any other "## " heading ends the thread above it.
  in_thread <- Reduce(function(prev, i) if (grepl("^## ", text[i])) is_head[i] else prev,
                      seq_along(text), accumulate = TRUE, FALSE)[-1]
  cites <- grepl("^- s\\d{2}e\\d{2}", text) & owner > 0 & in_thread
  out <- lapply(seq_len(sum(is_head)), function(i) {
    sub("^- (s\\d{2}e\\d{2}).*", "\\1", text[cites & owner == i])
  })
  setNames(out, id[is_head])
}

lint_recap <- function(text, file, name_table, threads) {
  fences <- which(text == "---")
  if (length(fences) < 2 || fences[1] != 1) return("no frontmatter")
  fm <- tryCatch(yaml::yaml.load(paste(text[2:(fences[2] - 1)], collapse = "\n")),
                 error = function(e) NULL)
  if (!is.list(fm)) return("invalid frontmatter: not a YAML mapping")
  missing <- setdiff(required_keys, names(fm))
  problems <- if (length(missing)) paste0("missing key: ", missing) else character()

  ep <- fm[["episode"]]
  if (!is.null(ep)) {
    if (!grepl("^s\\d{2}e\\d{2}$", ep)) {
      problems <- c(problems, paste0("episode ", ep, " is not sXXeYY"))
      ep <- NULL  # skip the checks below that compare against it
    } else if (ep != sub("\\.md$", "", basename(file))) {
      problems <- c(problems, paste0("episode ", ep, " does not match file"))
    }
  }

  body <- text[-seq_len(fences[2])]
  h1 <- sub("^# ", "", grep("^# ", body, value = TRUE)[1])
  if (!is.null(fm[["title"]]) && !identical(fm[["title"]], h1)) {
    problems <- c(problems, "title does not match H1")
  }
  if (!is.null(fm[["source_tier"]]) && !fm[["source_tier"]] %in% c("zoom", "youtube")) {
    problems <- c(problems, "source_tier must be zoom or youtube")
  }
  if (!is.null(fm[["recorded"]]) && !grepl("^\\d{4}-\\d{2}-\\d{2}$", fm[["recorded"]])) {
    problems <- c(problems, "recorded must be YYYY-MM-DD")
  }
  if (!is.null(fm[["recap_prose"]]) &&
      !grepl("^(generated|dm_intro s\\d+e\\d+)$", fm[["recap_prose"]])) {
    problems <- c(problems, "recap_prose must be 'generated' or 'dm_intro sNeN'")
  }

  slug_types <- c(npcs = "npc", places = "place", items = "item")
  for (field in names(slug_types)) {
    for (slug in unlist(fm[[field]])) {
      type <- name_table$type[name_table$slug == slug]
      if (!length(type)) {
        problems <- c(problems, paste0(field, ": unknown slug ", slug))
      } else if (type[1] != slug_types[[field]]) {
        problems <- c(problems, paste0(field, ": ", slug, " is a ", type[1]))
      }
    }
  }

  for (id in unlist(fm[c("threads_opened", "threads_advanced", "threads_closed")])) {
    if (is.null(threads[[id]])) {
      problems <- c(problems, paste0("unknown thread ", id))
    } else if (!is.null(ep) && !ep %in% threads[[id]]) {
      problems <- c(problems, paste0(id, " does not cite ", ep))
    }
  }

  for (cb in unlist(fm[["callbacks"]])) {
    if (!grepl("^s\\d{2}e\\d{2}$", cb)) {
      problems <- c(problems, paste0("callback ", cb, " is not sXXeYY"))
    } else if (!is.null(ep) && cb >= ep) {
      problems <- c(problems, paste0("callback ", cb, " is not earlier than ", ep))
    }
  }
  problems
}

# CLI: lint each file, print "file: problem" lines, exit 1 if any.
# names.md and threads.md are read from the vault root above sessions/.
if (sys.nframe() == 0L) {
  files <- commandArgs(trailingOnly = TRUE)
  if (!length(files) || !all(file.exists(files))) {
    writeLines("usage: Rscript tools/lint_recaps.R <recap.md> ...  (all files must exist)")
    quit(status = 2)
  }
  vault <- dirname(dirname(normalizePath(files[1])))
  name_table <- read_names(readLines(file.path(vault, "names.md"), warn = FALSE))
  threads <- read_threads(readLines(file.path(vault, "threads.md"), warn = FALSE))
  problems <- unlist(lapply(files, function(f) {
    p <- lint_recap(readLines(f, warn = FALSE), f, name_table, threads)
    if (length(p)) paste0(basename(f), ": ", p)
  }))
  writeLines(if (length(problems)) problems else paste(length(files), "recaps OK"))
  quit(status = as.integer(length(problems) > 0))
}
