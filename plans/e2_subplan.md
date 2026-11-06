# E2: Arc 1, The Monolith — subplan

**On approval, first action: copy this file to `plans/e2_subplan.md`.** Then work the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) has one epic per arc, E2…E8. E1 built the spine and set seven arcs. E2 covers arc 1, **The Monolith** (`monolith`, s02e01–s02e05): the crew escape the prison Monolith with Phthalos, and it ends with the Monolith in the ocean and the moon's eerie smile. The outcome is five full recaps in `BarquentineWiki/sessions/` and a three-paragraph arc recap. Each one meets the per-episode DoD.

## Goal

Write `s02e01.md`–`s02e05.md` and the arc 1 recap. Each passes lint, the VTT grep and the DM's line-edit, and it is committed.

## Inputs

- **VTTs:** `/Volumes/share/videos/Barquentine! S2E1 Definitely not full of muscles…`, `S2E2.transcript.vtt`, `S2E3 TreBlueChet…`, `S2E4.transcript.vtt`, `S2E5 , It's called Pacifism, everyone!…`, plus `S2E6 2 hours until sunrise…` (its opening recaps E5).
- **DM intro docs** (`read_doc`): S2E2 → E1 prose, S2e4 → E3, S2E5 → E4, S2E6 → E5. **S2E3 doc is prep notes: spelling only.** IDs are in `CLAUDE.md`.
- `season2_spine.md` arc 1 lines, `names.md`, `threads.md`, `recap_playbook.md`, the s03e05 recap as the format model.

## Decisions taken (change any at approval)

| Decision | Choice |
|---|---|
| `recorded:` | `~` for all five (no play date on file; lint accepts null) |
| `source_tier` | `youtube` |
| `recap_prose` | E1 `dm_intro s2e2`, E2 `generated`, E3 `dm_intro s2e4`, E4 `dm_intro s2e5`, E5 `dm_intro s2e6` |
| Titles | Filename titles for E1, E3, E5. E2 and E4 get a phrase spoken at the table, found in the cleaned transcript |
| Name for Cyan | **Blue** in all prose; slug `cyan` |
| Arc recap location | New `### Arc recap` block under the Arc 1 heading in `season2_spine.md` |
| Cite format | `[VTT hh:mm:ss]` for the episode's own lines, `[Recap s02eNN hh:mm:ss]` for the next episode's opening |

## Stories

### S1 · Sources ready (~30 min)
- **Tasks:**
  1. Clean all six VTTs into the scratchpad with `vtt_to_transcript()`.
  2. Read the five intro docs into scratch files.
  3. For each intro, find where it was read aloud in the next VTT and note any place the read-aloud differs. The read-aloud wins.
- **Success:** six cleaned files, four intros with read-aloud timestamps, and a diff list (it can be empty).
- **Check:** `wc -l` on the cleaned files. Eyeball each intro against its read-aloud.

### S2–S6 · One recap per episode, E1 → E5 (~45–60 min each)
Per episode:
- **Tasks:**
  1. Read the whole cleaned transcript.
  2. Hold the four-persona panel (the playbook) on what this episode's story is. For DM-intro episodes the panel shapes the Lore Notes and Open Threads, not the prose.
  3. Draft the prose. DM-intro episodes: copy the intro verbatim, drop the "Previously on" cue. E2: write it, ≤4 paragraphs, 1–2 quotes, closing tagline.
  4. Write the Lore Notes (each item cited) and Open Threads (written as of this episode, pointing to payoffs only as *(SxEy pays off.)*).
  5. Add new names to `names.md` (keep alphabetical) and new threads or bullets to `threads.md`, **before** citing them in the frontmatter.
  6. Grep every quote and named event against the **raw** VTT with the `awk` command. Search the cleaned text too, since raw line breaks split phrases (E1 Retro).
  7. Run lint on the file.
- **Success:** the file passes lint. Every quote has a timestamp. No reveals from E6 or later in the prose. YouTube quotes are attributed only when the speaker is unambiguous.
- **Check:** `Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e0N.md`

Expected thread work: `T-018` opens in s02e01 (already seeded). `T-003` advances in s02e03. Likely new threads: the escape from the Monolith (opens E1, closes E5) and Phthalos as an uneasy ally (opens E1, links to `T-017`). Likely new names: the Monolith (place), the scarab, Ted (already `s02e05`), Phthalos if missing.

### S7 · Arc recap (~20 min)
- **Tasks:** write exactly three paragraphs for arc 1 under the Arc 1 heading in `season2_spine.md`. Written as of E5.
- **Success:** three paragraphs, no post-E5 content, quotes reused only from the five verified recaps.

### S8 · DM line-edit (~DM's time, then 15 min)
- **Tasks:** hand the five recaps and the arc recap to the DM. Apply edits without pushback, redraft only the sections the DM touches.
- **Success:** the DM approves. Quote the approval in the Retro.

### S9 · Review and commit (~15 min)
- **Tasks:**
  1. Check the diff for DM prep notes, future-arc material and `brewed_lore/`.
  2. Run the exit check.
  3. Tick E2 in the roadmap.
  4. **Ask before committing.**

## Skill calls

- `handoff` at the end of each sitting (save to `BarquentineWiki/handoffs/`).
- `session-close`: optional, at close.
- No `tdd` or `code-review`: no tooling changes are planned.

## Risks

- **Caption mangling** of Phthalos, Luminariel, Vermilion. Mitigation: `names.md` variants; flag guesses as *Anomaly* in Lore Notes.
- **The intro doc differs from what was played** (the s02e35 lesson). Mitigation: S1 step 3. The DM decides any conflict.
- **Spoiler leakage.** Phthalos dies in E10 and Blue becomes Cyan in E12. Neither may appear in arc 1 prose. Payoffs stay in `threads.md`.
- **Unattributable quotes** (no speaker labels). Mitigation: narrate the moment instead.
- **Common-word name hits** in greps (E1 Retro). Check context on every hit before citing it.
- **Time:** about 4–6 h across 2 sittings. Planned split: sitting 1 = S1 + E1–E3. Sitting 2 = E4, E5, S7–S9.

## Exit check (run it and paste the output into the Retro)

```bash
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e0[1-5].md BarquentineWiki/sessions/s03e*.md; echo "exit=$?"
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
ls BarquentineWiki/sessions/s02e0[1-5].md | wc -l          # 5
grep -c '^### Arc recap' BarquentineWiki/season2_spine.md  # >= 1
grep -n 'Cyan' BarquentineWiki/sessions/s02e0[1-5].md || echo "no Cyan"  # arc 1 says Blue
git diff --cached | grep -iE 'brewed_lore|prep' || echo "no leaks"
```

## DM decisions during the epic

- 2026-11-06: when the read-aloud adds lines the intro doc lacks (E3), keep the doc prose verbatim and quote the extra lines in Lore Notes. "fine."
- 2026-11-06: in DM-intro prose, normalize name spellings to canon (Luminarael → Luminariel, Vermillion → Vermilion) and leave other typos alone. "fine."

## Retro (filled at close)

**Exit check output (2026-11-06, before the DM's line-edit)**

```
11 recaps OK
exit=0
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 35 ]
5            # s02e01–s02e05 present
1            # arc recaps in season2_spine.md
no Cyan
no leaks
```

**DM approval (2026-11-06):** "line edits are good to go." No changes to the five recaps or the arc recap.

**What happened**
- One sitting, not two. The DM chose to keep going through E4 and E5 rather than hand off.
- Recaps: four use DM intro prose (E1, E3, E4, E5); E2 is generated. The E2 and E4 titles are spoken phrases, now in the spine with ✓.
- Ledgers: T-025 (Escape from the Monolith) opened and closed inside the arc. T-026 (The smiling moon) opens in s02e05. New names: `lucy`, `scarab_head`, `hoot_suit`, `phthalos_belt`, `sea_chart`.
- First-seen values were checked against the E4 and E5 transcripts. `robe_of_useful_items` stays s02e14.
- Read-aloud extras the docs lack, in E3, E4 and E5, are quoted in Lore Notes per the DM's ruling.

**Tooling added**
- `tools/vgrep.sh`: a two-line-window, case-insensitive VTT grep. The CLAUDE.md single-line `awk` missed many quotes because captions split phrases.
- Cleaned transcripts now live in `cache/transcripts/` (git-ignored). CLAUDE.md step 1 updated.
- `read_doc` returns truncated JSON for the per-episode docs. Drive `read_file_content` returns plain text.

**Change in E3 subplan**
- Start by cleaning every arc transcript into `cache/transcripts/`; E3 also needs whichever later opening recaps E12 (check the spine's cite for s02e12).
- Expect ~25k tokens per cleaned transcript. Five recaps fit in one sitting; arc 2 has seven, so plan two sittings.
- Grep with `tools/vgrep.sh` from the start.
