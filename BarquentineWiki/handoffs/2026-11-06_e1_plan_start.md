# Handoff: start the E1 subplan (Season 2 spine)

**Date:** 2026-11-06
**Next session focus:** in plan mode, write `plans/e1_subplan.md` (E1: Season 2 spine) from the roadmap's subplan template. **Build nothing until the user approves it.**

## Read first, in order

1. `plans/s2_backfill_roadmap.md`: E1's row (outcome, DoD, estimate), the subplan template, the per-episode DoD, and the `grill-me` skill call at the end of E1.
2. `plans/e0_subplan.md`, especially the **Retro**. It has lessons for E1.
3. `CLAUDE.md`: workflow, the **Season 2 sources** section (verified GMT map and DM intro-doc mapping), lint and test commands.
4. `recap_playbook.md`: the **Frontmatter**, **Spoiler rule** and **YouTube-tier transcripts** sections, all new in E0.
5. `BarquentineWiki/names.md` and `BarquentineWiki/threads.md`: the formats E1 extends. Both are seeded from S3 and DM-approved.

## E0 is done

- The commits are `b2312ef` and `14fb14f` on `main`. See `git log` and the E0 Retro, not this file.
- The tools E1 needs:
  - `vtt_to_transcript(path)` auto-detects a YouTube file and returns `[hh:mm:ss] text` blocks of about a minute. The opening "Previously on" is usually the first 1–3 blocks.
  - `tools/lint_recaps.R` validates the frontmatter.

## Facts for E1 that aren't written down anywhere else

- **The NAS** has 43 `Barquentine! S2E*` files. It must be mounted at `/Volumes/share/videos` (see CLAUDE.md for how).
  - These include titled YouTube copies of S2E34–S2E43. The Zoom GMT copy wins for recaps, but the YouTube filenames give **episode titles** for every episode except S2E41.
  - Titled filenames exist for most of S2E1–33 too. A filename's title is a candidate recap title, but the playbook says it must be a phrase spoken at the table, so grep for it.
- **S2E41 has no DM "Previously on".** The Captain's player recaps instead [VTT 00:00:00 of GMT20260414]. Cite that segment for E41's spine line.
- **S2E7** is split into Part 1 and Part 2. **S2E20** has no transcript. Both facts are in the roadmap. The spine needs a line for each anyway: a stub for E20, and one line covering both parts of E7.
- **The DM intro doc** (`1m5xXbEsPBFdTZAUoUAgj6a14I7aF8LcszCmX-r1mBbs`) is too big for `read_doc` (673k chars). The tool saves its output to a file; read that file with `jq`:
  - Tab titles: `.content.tabs | .. | objects | select(has("tabProperties")) | .tabProperties.title`
  - Tab text: `.documentTab.body.content[].paragraph.elements[].textRun.content`
- **The intro doc also holds DM prep-note tabs:** S2e14–S2E17, S2E25, s2e26, s2e32 and "Tab 7". Use them **for spelling only**. Never put their content in a tracked file.
- **The S3 recaps have `arc: ~`.** E1 names the S2 arcs. Ask the DM whether S3E1–6 get an arc slug now or later.
- **`names.md` "first seen" is S3 for every seed.** E1 moves each name back to its S2 episode, and adds the S2 names, including the PC roster check (S1 had Pyxis).
- **Stale memory:** the `project_s2_backfill.md` memory in `~/.claude/projects/-Users-jasongrahn-R-projects-barquentine-pipeline/memory/` still says "Next epic = E0" and "not a git repo". Update it or ignore it.

## Constraints

- **The repo is PUBLIC and players read it.** Check every commit for future-arc material, DM prep notes and `brewed_lore/` content. `brewed_lore/` is gitignored and stays that way.
- **The spoiler rule:** spine lines are written as of their own episode. Payoffs go only in `threads.md`.
- **Arc boundaries are the DM's call.** Propose them, then stress-test them with `grill-me`. Don't settle them alone.
- Lesson from the E0 Retro: **inspect the real files before designing anything.** In E0, half the planned parser work was for problems the files didn't have.
- **The user has ADHD.** Lead each reply with the next action, and end with one step that takes under 2 minutes.

## Loose ends (not E1)

- These are still uncommitted, by the user's choice:
  - `BarquentineWiki/handoffs/2026-11-06_e0_plan_start.md`
  - `BarquentineWiki/handoffs/2026-11-06_s2_backfill_e0.md`
  - `BarquentineWiki/locations/`
  - `BarquentineWiki/npcs/basil.md`
- Ask the user before committing any of these, and check them for DM-only content first.

## Suggested skills

- **`EnterPlanMode` first.** Write the subplan there, call `ExitPlanMode` for approval, then copy it to `plans/e1_subplan.md`.
- `grill-me`: at the end of E1, to stress-test the arc boundaries and the thread list with the DM. The roadmap requires it.
- `handoff`: at the end of the sitting. Save to `BarquentineWiki/handoffs/`, not the OS temp dir (CLAUDE.md overrides the skill default).
- `session-close`: optional, at the end of the sitting.
