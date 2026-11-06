# E1: Season 2 spine — subplan

**On approval, first action: copy this file to `plans/e1_subplan.md`.** Then work through the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) needs a map of Season 2 before any arc epic can start. Its E1 row: build `BarquentineWiki/season2_spine.md` (one line per episode, arc boundaries), and extend `names.md` / `threads.md` with S2. **DoD:** the DM approves the arc boundaries, and every E2–E43 opening is cited by a spine line.

## What inspection of the real files showed (2026-11-06)

- NAS is mounted. 43 `Barquentine! S2E*` YouTube files = E1–E43 minus E20, with E7 as Part 1 + Part 2. 10 GMT Zoom files cover E34–E43.
- Each YouTube transcript cleans to ~100–150 one-minute blocks (~2 h of play). Reading 42 whole transcripts is out of scope for E1. **The spine is built from openings:** episode N's line comes from the recap at the top of episode N+1.
- Openings are not uniform. A keyword scan misses a lot, so every opening must be read by eye:
  - DM "Previously on" (e.g. E8, E33).
  - A player recapping on the DM's request ("does anybody want to catch us up", e.g. E21 in detective noir).
  - E1 is season-opening narration (the Sentinel prison ship). It recaps nothing.
  - E2's recap starts after table talk, inside block 1.
- **E20 is not a dead end.** E21's opening recaps hideout, vampires, the two-knob door and Periwinkle. None of these appear anywhere in E19. So E21's opening is E20's source. E20 gets a real line marked *(no transcript; from s02e21 opening)*.
- **PC roster:** E1–E2 openings name Basil, Room, "Luminario" (Lumi) and **Blue**. Pyxis is "no longer among the ranks". Blue isn't in the playbook's table facts. The roster check has to settle who Blue is and when Blue leaves.
- `tools/lint_recaps.R` only requires `arc` to be present. Any slug passes, so naming arcs needs no tooling change.

## Inputs

- `/Volumes/share/videos/Barquentine! S2E*.transcript.vtt` (E1–E33 openings).
- GMT files 20251223–20260519 (E34–E43 openings; the Zoom copy wins, cite `[VTT hh:mm:ss]`).
- The DM intro doc `1m5xXbEsPBFdTZAUoUAgj6a14I7aF8LcszCmX-r1mBbs`, **intro tabs only** (s2e33–S2e43 → E32–E42). Read with `read_doc` → saved file → `jq` (paths in the E1 handoff). Prep tabs only for spelling.
- `BarquentineWiki/names.md`, `threads.md`, `recap_playbook.md`, `tools/vtt_clean.R`.

## Decisions taken (change any at approval)

| Decision | Choice |
|---|---|
| Line source | E1–E30: opening of E(N+1). E31: E32 opening. E32–E42: DM intro tab s2e(N+1), cross-checked against the read-aloud in E(N+1). E43: see Risks. |
| Citation | `[Recap s02eNN hh:mm:ss]`, where NN is the episode whose opening holds the recap. For E32–E42 add `· tab s2eNN`. |
| Who recaps | Tag player recaps `(player recap)`. They are less reliable than the DM's. |
| Titles | Filename title as a candidate. Grep it in that episode's VTT; mark `✓ spoken` or `? unverified`. E2 and E41 have no filename title: `—`. |
| Spine format | One H2 per arc (`## <arc-slug> · <Name> (s02eAA–s02eBB)`), one bullet per episode: `- **s02eNN · Title** — line. [cite]`. A flat list until arcs are approved. |
| Line length | One sentence, ≤ 30 words, written as of its own episode (spoiler rule). |
| Scratch | Opening dumps go in the session scratchpad, never in the repo. |

## Stories

### S1 · Dump and read every opening (~45 min)
- **Tasks:**
  1. Write the first 5 blocks of each YouTube file, and the first ~60 cue lines of each GMT file, to one scratch file per episode.
  2. Pull the intro-tab text for s2e33–S2e43 from the doc into scratch.
  3. Read each one. Record a source table in scratch: episode → source file, timestamp, DM or player, the end of the recap segment.
- **Success:** 43 rows (E7 = one row, E20 = one row). Every row has a timestamp or an explicit "none" with a reason.
- **Check:** `wc -l` on the source table. Eyeball E1, E20, E41, E43.

### S2 · Write the spine lines (~40 min)
- **Tasks:**
  1. Draft `BarquentineWiki/season2_spine.md` as a flat list, E1–E43.
  2. Fix mangled names via `names.md` variants and prep-tab spelling. Flag guesses as `(?)`.
  3. Grep each filename title in its own VTT (`awk` timestamp command from CLAUDE.md); set ✓ or ?.
  4. Grep every proper noun in the lines against the raw VTT.
- **Success:** 43 bullets. Every bullet has a citation. No content from later episodes.
- **Check:** `grep -c '^- \*\*s02e' season2_spine.md` = 43. `grep -c '\[Recap' …` ≥ 42.

### S3 · Propose arc boundaries (~20 min)
- **Tasks:**
  1. Group the lines into ~8–9 arcs. Cut where the location or the crew's goal changes (e.g. the Sentinel and Monolith prison at the start, the Flotilla at the end).
  2. Give each arc a slug, a name and a one-line reason for each boundary.
  3. Write them into the spine as a **Proposed arcs** table. Don't restructure into H2s yet.
- **Success:** every episode belongs to exactly one arc.
- **Check:** the ranges cover 1–43 with no gaps or overlaps (read the table).

### S4 · Extend `names.md` (~30 min)
- **Tasks:**
  1. For each S3 seed, find its earliest S2 episode by grepping the canonical name plus variants across the S2 files in episode order. Move `first seen` back.
  2. Add the S2 names that the spine lines use (PCs including Blue, NPCs, places, items), each with variants and `first seen`.
  3. Settle the PC roster: who Blue is, and when Blue and Pyxis leave. Record this in the playbook's **Table facts**.
- **Success:** every proper noun in the spine has a row. `first seen` is the earliest S2 episode found.
- **Check:** the lint on `s03e*.md` still exits 0. Spot-check 3 `first seen` values with grep.

### S5 · Extend `threads.md` (~30 min)
- **Tasks:**
  1. Add S2 threads that the spine shows opening (T-014 onward). Bullets only for episodes the spine cites.
  2. Add S2 setup bullets to the existing T-001–T-013 where the spine shows them (e.g. Alistair and Victoria, the ship).
  3. Payoff text goes only in `threads.md`, never in spine lines.
- **Success:** every thread has ≥ 1 cited episode bullet. Episodes are listed in order.
- **Check:** the lint on `s03e*.md` exits 0. Read the new threads for any S3-unplayed or prep-note content.

### S6 · Grill the DM on arcs and threads (~30 min)
- **Tasks:**
  1. Run `grill-me` on the proposed arcs, the thread list, and these open questions:
     - Do S3E1–6 get an arc slug now, or later?
     - What source does E43's line use?
     - Blue's identity, if the transcripts don't settle it.
  2. Apply the decisions: restructure the spine into arc H2s, add a slug column, and update the roadmap's E2…En rows with the real arc count.
  3. If the DM says "now", set `arc:` in `s03e*.md`.
- **Skill:** `grill-me`
- **Success:** the DM states approval of the boundaries.
- **Check:** the approval is quoted in the Retro.

### S7 · Review and commit (~15 min)
- **Tasks:**
  1. Check the diff for future-arc material, prep-note content and `brewed_lore/`.
  2. Run the exit check.
  3. **Ask the user** before committing. Tick E1 in the roadmap. Fill in the Retro.
  4. Run `handoff` into `BarquentineWiki/handoffs/`.
- **Skill:** `handoff`
- **Check:** `git show --stat HEAD`.

## Risks

- **Time.** About 3.5 h total, against the roadmap's ~2 h (E0 also overran). Natural split: **Sitting A = S1–S3**, **Sitting B = S4–S7**. The handoff goes between them.
- **A recap blurs two episodes**, or a player recap is wrong. Mitigation: cross-check against the next episode's first non-recap blocks, tag player recaps, and ask in S6.
- **E43 has no following S2 opening.** The S3 "See1 intro" is season-opening narration. Fallback: E43's last ~10 blocks plus See1, tagged `(from own closing)`. The DM confirms in S6.
- **Openings with no recap at all** (E1, and possibly E29 "interlude"). Fallback: that episode's own first blocks, tagged.
- **Spoiler leakage into `threads.md` payoffs.** All of S2 has been played, so S2 payoffs are fine. Anything S3-future or from prep notes is not.

## Exit check (run, paste output into the Retro)

```bash
grep -c '^- \*\*s02e' BarquentineWiki/season2_spine.md          # 43
grep -c '\[Recap' BarquentineWiki/season2_spine.md               # >= 42
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s03e*.md; echo "exit=$?"
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
git diff --cached | grep -iE 'brewed_lore|prep' || echo "no leaks"
```

## Retro (filled at close)

**Exit check output (2026-11-06)**

```
43        # spine episode lines
41        # [Recap cites; the other 4 lines (E11, E19, E28, E43) cite their own VTT, since no recap of them exists
6 recaps OK
exit=0
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 35 ]
no leaks
```

**DM approval:** the DM answered the three arc questions in the spine itself: "no" (no splits), E23 is "the start of 5", E31 is to "open 6". They corrected the names in the spine and approved `names.md` ("Names = good, but maybe we make it alphabetical order") and `threads.md` ("Threads = good"). Further decisions: S3 `arc:` slugs come later; S2 filename titles stand even when unspoken; the `npcs/ted.md` deletion is committed.

**What happened**
- Seven arcs, not the roadmap's ~8–9. E2…E8 = one epic per arc.
- E20 has no transcript, but E21's opening recaps it, so it has a real line.
- E11 is a Halloween special, made canon in E14. Blue becomes Cyan in E12 and leaves in E14. Pyxis is gone before E1.
- E28 and E29 got no recap (E30 recaps E27), so their lines come from their own transcripts.
- No grill-me run was needed. The DM settled the arcs by editing the spine directly.

**Mistakes caught before commit**
- The first title-grep counted 10 spoken titles. It searched raw VTTs, whose line breaks split phrases. Re-run on cleaned text, it found 17.
- The E37–E40 titles were shifted by one. I'd assumed S2E40 had no filename title. Fixed by comparing every spine title against its filename.
- The DM changed "four prices" to "3 prices" for E35. The s2e36 intro tab lists four options. Left as the DM wrote it, and flagged.

**Change in the E2 subplan**
- Compare derived lists (titles, first-seen) against the source files mechanically before calling them done.
- Name-grep hits on common words (billow, catastrophe, burger, rock, map) need a context check. Several first-seen values were false positives until checked.
- Time: ~2.5 h in this sitting, against the plan's 3.5 h. Opening dumps plus batch reads were fast.
