# E0: Tooling & rules — subplan

**On approval, the first action is to copy this file to `plans/e0_subplan.md`.** Then work through the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) needs working tools before any arc epic can start. Four things are missing:

- `tools/vtt_clean.R` collapses a YouTube VTT (no speaker labels) into **one line**. Every speaker is `""`, so the run-merge treats the whole file as one run.
- No frontmatter schema, `names.md`, `threads.md` or linter exists.
- The GMT→episode map for E37–E43 is inferred, not verified.
- The playbook has no YouTube-tier rules, schema, S2 intro mapping or spoiler rule.

The roadmap's E0 Definition of Done:
1. A cleaned YouTube file gives timestamped, multi-line output.
2. Lint passes on the 6 S3 recaps once their frontmatter is added.
3. The GMT→E37–43 map is verified.

## Goal

Get the tooling, schema and rules to the point where E1 can start: the cleaner reads both tiers, a lint gates every recap, and the playbook holds the S2 rules.

## Inputs

- `tools/vtt_clean.R`: the current cleaner, 26 lines, with one function `vtt_to_transcript(path)`.
- NAS `/Volumes/share/videos/`. **Not mounted right now.** Mount it with Finder → Go → Connect to Server → `smb://LS220D43E.local/share`.
  - The YouTube tier files: `Barquentine! S2E*.transcript.vtt`
  - The Zoom tier files: `GMT2026*_Recording.transcript.vtt`
- The Google Doc "Barquentine Episode notes" (`1m5xXbEsPBFdTZAUoUAgj6a14I7aF8LcszCmX-r1mBbs`): the s2e33–s2e43 intro tabs.
- `BarquentineWiki/sessions/s03e01–06.md`: no frontmatter today, only an H1 and an italic header line.
- `CLAUDE.md` and `recap_playbook.md`.
- R packages `testthat` and `yaml` are already installed (checked).

## Decisions taken (change any of these at approval)

| Decision | Choice |
|---|---|
| Test setup | `testthat` 3e under `tools/tests/`. Fixtures go in `tools/tests/fixtures/`, and `helper-source.R` sources `../vtt_clean.R` and `../lint_recaps.R`. Run with `Rscript --vanilla -e 'testthat::test_dir("tools/tests")'`. |
| Cleaner API | Keep `vtt_to_transcript(path)` so the CLAUDE.md command still works. Split it into pure functions: `parse_vtt(lines)` → a cue data frame (`start`, `speaker`, `text`), `format_speaker_runs(cues)` (today's Zoom output, byte-identical) and `format_time_blocks(cues, secs = 60)`. The mode is auto-detected: if fewer than 50% of cue lines carry a speaker label, use time blocks. An optional `mode=` arg overrides it. |
| YouTube dedupe | Drop a caption line that repeats the line just before it (rolling auto-captions). Strip inline `<…>` timing tags. Drop the `Kind:` and `Language:` header lines. Leave `[ __ ]` as-is. **Confirm all of this against a real file in S1.1 first.** |
| Lint scope | `lint_recaps.R` errors on the old pipeline-format files (`s02e34–36`). That's correct: Ez retires them. The E0 exit check runs only on `s03e*.md`. |
| `names.md` format | One markdown table: `slug \| canonical \| type (pc/npc/place/item/faction) \| transcript variants \| first seen`. Lint checks that each slug exists and that its type matches the frontmatter key (`npcs` → npc, `places` → place, `items` → item). |
| `threads.md` format | One `## T-### · <title>` heading per thread, then `status:` and an `episodes:` bullet list of `sXXeYY — what happened`. Lint checks that the id exists and that the entry cites the recap's episode. |
| `arc` key | Required, but `~` (null) is allowed until E1 names the arcs. S3 recaps get `arc: ~` for now. |
| `recap_prose` | `generated`, or `dm_intro <tab>`, matching the CLAUDE.md table. S3E1 → `dm_intro s3e2`, S3E2 → `dm_intro s3e3`, S3E3 → `dm_intro s3e4`, S3E4 → `dm_intro s3e5`, S3E5 → `dm_intro s3e6`, S3E6 → `generated`. |
| Seed scope | E0 seeds `names.md` and `threads.md` with **only the S3E1–6 entries** the six recaps need. E1 adds S2. Everything in them has already been played at the table, so the public repo is fine. |

## Stories

### S1 · Cleaner handles YouTube VTTs
- **Tasks:**
  1. Mount the NAS. Run `head -80` on one YouTube VTT and one Zoom VTT to confirm the real format: rolling lines, inline tags, header lines.
  2. Cut short excerpts into fixtures: `youtube_s2e33_head.vtt` (~3 min) and `zoom_e34_head.vtt` (~3 min).
  3. Write a characterization test: the current `vtt_to_transcript()` on the Zoom fixture, saved as the expected output.
  4. Use TDD (red → green) to build `parse_vtt`, `format_time_blocks` and auto-detect. Refactor `format_speaker_runs` while the characterization test stays green.
- **Skill:** `tdd`
- **Success:**
  - The Zoom output is byte-identical to before.
  - The YouTube output is multi-line `[hh:mm:ss] text`, with blocks ≤ ~60 s and no duplicated rolling lines.
- **Check:**
  - The test suite passes.
  - Clean the full S2E33 file and confirm `wc -l` > 50 and that the first block starts `[00:00:`.

### S2 · Verify the GMT → E37–E43 map
- **Tasks:**
  1. For each of the 7 GMT files, pull its opening ~3 min (the "Previously on").
  2. Match each opening to the doc's `s2eN intro` tab. Tab `s2eN` is read **at the start of** episode N.
  3. Record the confirmed map, plus any mismatch.
- **Skill:** none. This is a read-and-compare job, done with Google Docs `read_doc` and `head` on the raw VTT.
- **Success:** each GMT file maps to one episode, backed by a cited intro match.
- **Check:** a table of `GMT date | episode | matching phrase | [VTT hh:mm:ss]`, with each phrase grepped with the CLAUDE.md `awk` command.

### S3 · Finalize the schema and seed the ledgers
- **Tasks:**
  1. Write the final frontmatter schema into the playbook: the roadmap draft plus the decisions above.
  2. Create `BarquentineWiki/names.md` with the S3 PCs, NPCs, places and items, taken from the six recaps' Lore Notes.
  3. Create `BarquentineWiki/threads.md` with the S3 threads (for example the sphere key, Mira's hoard, the hungry ship), each citing its episodes.
- **Skill:** none.
- **Success:** both files follow the formats above. Every name and thread is backed by an S3 recap, so nothing comes from `brewed_lore/` or prep notes.
- **Check:** DM review of the two files. Grep that nothing in them comes from `brewed_lore/`.

### S4 · `tools/lint_recaps.R`
- **Tasks:**
  1. Use TDD to build the pure function `lint_recap(text, file, names, threads)`, which returns a character vector of problems. The checks:
     - the YAML parses
     - the required keys are present
     - `episode` matches the filename and `^s\d{2}e\d{2}$`
     - `title` equals the H1
     - `source_tier` is in {zoom, youtube}
     - `recorded` is a date
     - `recap_prose` has a valid form
     - slugs and types are found in `names.md`
     - thread ids exist and their entries cite this episode
     - `callbacks` are valid ids from earlier episodes
  2. Add pure parsers `read_names(text)` and `read_threads(text)`.
  3. Add a CLI guard: `Rscript tools/lint_recaps.R <files…>` prints problems and exits with 1 if any are found.
- **Skill:** `tdd`
- **Success:** each check has at least one failing-case test and one passing-case test, and the CLI exit codes are correct.
- **Check:**
  - The test suite passes.
  - Running the lint on `s02e34.md` exits 1 (the legacy format is caught).

### S5 · Frontmatter on the six S3 recaps
- **Tasks:**
  1. Add a YAML block above the H1 in each `s03e0*.md`. Keep the italic header line.
  2. Fill each block from that recap's own text and Lore Notes only.
- **Skill:** none.
- **Success:** the lint exits 0 on all six. The recap prose is unchanged.
- **Check:**
  - `Rscript tools/lint_recaps.R BarquentineWiki/sessions/s03e*.md; echo $?` prints `0`.
  - `git diff` shows additions only, above each H1.

### S6 · Playbook and CLAUDE.md rules
- **Tasks:** add five things.
  1. The YouTube-tier rules, finalized from the roadmap draft.
  2. The spoiler rule: prose is written as of its own episode, and payoffs live only in `threads.md`.
  3. The S2 DM-intro mapping table (s2e33–s2e43 → E32–E42).
  4. The verified GMT map.
  5. The test and lint commands, plus the `names.md` and `threads.md` paths.
- **Skill:** none.
- **Success:** a fresh session could run E1 from CLAUDE.md and the playbook alone.
- **Check:** reread both files against the E1 inputs list in the roadmap.

### S7 · Review and commit
- **Tasks:**
  1. Run `code-review` on the tooling diff and fix what it finds.
  2. Check every staged file for spoilers and DM-only content.
  3. **Ask the user** before committing. The roadmap gets E0 ticked.
- **Skill:** `code-review`
- **Success:** the review is clean, there are no DM-only lines, and the commit is on `main`.
- **Check:** `git show --stat HEAD`. Grep the staged files for `brewed_lore` and prep-note phrases.

## Risks

- **The real YouTube VTT format is different from what I've assumed.** S1.1 inspects the file before any code gets written.
- **The NAS won't mount.** That blocks S1.1 and S2. Mitigation: do S3 and S4 first, which work from local files only.
- **A GMT opening doesn't match any intro tab**, for example a skipped session or a missing recording. Mitigation: record it as unverified and ask the DM. Don't guess.
- **Seeding the ledgers turns into an S2 lore dig.** Keep it strictly to S3.
- **Time.** 7 stories is more than the roadmap's ~1–2 h. A realistic estimate is 2.5–3 h. If the sitting runs long, split after S4.

## Exit check (run these and paste the output into the Retro)

```bash
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s03e*.md; echo "exit=$?"
Rscript --vanilla -e 'source("tools/vtt_clean.R"); x <- strsplit(vtt_to_transcript(commandArgs(TRUE)[1]), "\n")[[1]]; cat(length(x), "lines\n"); writeLines(head(x, 3))' "/Volumes/share/videos/Barquentine! S2E33 <title>.transcript.vtt"
grep -n "GMT2026" recap_playbook.md CLAUDE.md   # verified map present
```

## Retro (filled at close, 2026-11-06)

**Exit check output**

```
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 35 ]
6 recaps OK
exit=0
105 lines
[00:00:00] Things got real gross real fast aboard the Manticor. In the cramped confines of
[00:01:00] Shaken but not broken. The crew are greeted on deck by a strange welcome wagon
[00:02:03] the manticor ever forward in bid to reach the distant flotillaa before the thin
10   # GMT map rows in CLAUDE.md
```

Extra checks:
- All 16 Zoom files clean byte-identical to the pre-E0 cleaner.
- The lint exits 1 on legacy `s02e34.md`, and exits 2 with a usage line when given no arguments.

**What happened**
- The real YouTube VTTs are simpler than assumed: no rolling duplicates, no inline tags, no cue numbers, LF line endings. The planned dedupe and tag stripping weren't needed. `>>` marks a change of speaker, and it's documented in the playbook.
- The NAS also holds titled YouTube copies of S2E34–43. A six-word-phrase overlap against them verified the GMT map more strongly than the intro tabs alone. The intro tabs agree for every episode except E41, where the Captain's player gave the recap.
- `code-review` found 10 issues; 9 are fixed with tests:
  - bare-number captions (dice rolls) were dropped
  - empty files crashed every mode
  - YAML comments were read as the H1
  - malformed YAML aborted the CLI
  - stray `|` tables and `##` sections leaked into the ledgers
  - the CLI had no usage guard
  - the `names` parameter shadowed `base::names`
  - `fm$episode` partial-matched the old `episode_title` key (I caught this one myself)
- Skipped: a colon in a caption is read as a speaker label. YouTube output is unaffected, because blocks mode puts `speaker: text` back together.

**Change in the E1 subplan**
- Look at the real files before designing any parser. Half of the S1 design was for problems that didn't exist.
- Seed `names.md` spellings from the DM's own usage. Three guesses wait on DM review: Theodore, Trimnor, Philip.
- The lint asserts names and threads exist, not that they're right. The DM review of `threads.md` is the real check.
- Time: ~2.5 h, against the roadmap's 1–2 h.
