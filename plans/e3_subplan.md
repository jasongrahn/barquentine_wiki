# E3: Arc 2, The Sunken Ship — subplan

**First action once approved:** copy this file to `plans/e3_subplan.md`. Then work through the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) runs one epic per arc. E2 (arc 1, Monolith) is done in commit `7bcd0c7`, which hasn't been pushed. E3 covers arc 2, **The Sunken Ship** (`sunken_ship`, s02e06–s02e12, 7 episodes). The arc runs from the stolen ship and the compass hunt, through Phthalos's death and the Halloween special, to the ship rising through the whale with Basil as captain. The deliverable is seven recaps in `BarquentineWiki/sessions/` plus a three-paragraph arc recap. Each one meets the per-episode DoD.

## Goal

Write `s02e06.md`–`s02e12.md` and the arc 2 recap. Each one passes lint, the VTT grep and the DM's line-edit, and then gets committed.

## Inputs

- **VTTs** (`/Volumes/share/videos/`, all YouTube tier): `Barquentine! S2E6 2 hours until sunrise…`, `S2E7 Unexpected and Unappreciated Part 1…` + `Part 2…`, `S2E8 Definitely won't be a problem later..` (two dots), `S2E9 This guy you know…`, `S2E10 28 Bones Later…`, `S2E11 My A is Getting E'd…`, `S2E12 Im not sure what ive gotten us into…`, plus `S2E13 Chewing Mold…`, whose opening recaps E12.
- **DM intro docs** (Drive `read_file_content` by doc ID; IDs are in `CLAUDE.md`): S2e7 → E6, S2E8 → E7, S2E9 → E8, "S2 e10" → E9, S2E12 → E10. The "s2 e11" doc is the special's opening narration, so it's a spelling source only. **Everything after an intro is prep: spelling only, never written into a tracked file.**
- `season2_spine.md` arc 2 lines and **Notes and anomalies**, plus `names.md`, `threads.md`, `recap_playbook.md`, and `s02e01–05.md` as the format model.
- Tools: `tools/vtt_clean.R`, `tools/vgrep.sh`, `tools/lint_recaps.R`.

## Decisions taken (change any at approval)

| Decision | Choice |
|---|---|
| E7 | **One recap** (DM, 2026-11-06). `source:` is a YAML list of both files. Part 1 cites are `[VTT hh:mm:ss]`, Part 2 cites are `[VTT P2 hh:mm:ss]`. Lint has no type check on `source`. |
| Talk-show host | **Ciaran Silverhowl** (DM, 2026-11-06). Gets a new `names.md` row with the caption variants "Syrian silal" and "syan silver how". Remove the "unconfirmed" note from the spine anomalies. |
| `recorded:` | `~` for all seven |
| `source_tier` | `youtube` |
| `recap_prose` | E6 `dm_intro s2e7`, E7 `dm_intro s2e8`, E8 `dm_intro s2e9`, E9 `dm_intro s2e10`, E10 `dm_intro s2e12`, E11 `generated`, E12 `dm_intro s2e13` (the "E13" section at the bottom of the S2E12 doc; see DM decisions) |
| Titles | Filename titles where the spine marks them ✓ (E7–E10). For E6, E11 and E12 (marked ?), search the cleaned transcript first. If the phrase isn't spoken, pick one that is, as was done for E2 and E4 |
| Cyan's name | **Blue** in the E6–E10 prose. E11 (the flash-forward) says Cyan, as the episode does (DM, 2026-11-06). E12 says Blue until the color shift [VTT s02e12 00:08:32] and Cyan after it. The slug stays `cyan` |
| Spoilers | Phthalos is alive in the E6–E9 prose. The Ki-Rin = Manticore reveal stays out of the prose before E12 |
| Standing E2 rulings | Keep doc prose verbatim and quote read-aloud extras in Lore Notes. Normalize name spellings to canon and leave other typos alone |
| Arc recap location | A new `### Arc recap` block under the Arc 2 heading in `season2_spine.md` |

## Stories

### S1 · Sources ready (~30 min)
1. Clean E7 P1, E7 P2 and E8–E13 into `cache/transcripts/` (s02e06 is already there). Name the E7 files `s02e07_p1.txt` and `s02e07_p2.txt`.
2. Read the five intro docs, and the s2 e11 doc for spellings, into the scratchpad.
3. For each intro, find where it's read aloud in the next VTT and add any differences to `cache/transcripts/intro_diffs.md`. E10's intro is read at the top of **s02e12**.
- **Check:** `wc -l cache/transcripts/s02e*.txt`. Each intro has a read-aloud timestamp.

### S2–S8 · One recap per episode, E6 → E12 (~45–60 min each)
Run the same loop as the E2 stories:
1. Read the whole cleaned transcript.
2. Hold the four-persona panel. For DM-intro episodes, the panel shapes Lore Notes and Open Threads, not the prose.
3. Write the prose. For a DM intro, copy it verbatim and drop the cue line. E11 and E12 are generated: at most 4 paragraphs, 1–2 quotes, ending on the tagline.
4. Write Lore Notes (every item cited) and Open Threads, written as of the episode, with only a *(SxEy pays off.)* pointer for payoffs.
5. Add names and thread bullets **before** citing them in the frontmatter. Check the existing s02e06–12 bullets in `T-001`, `T-003`, `T-015`, `T-017` and `T-018` first.
6. Run `tools/vgrep.sh` on every quote and named event against the **raw** VTT.
7. Run `Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e<NN>.md`.

Thread work to expect:
- `T-017` closes in s02e12.
- `T-018` advances in E6, E8, E10 and E12.
- `T-026` (the smiling moon) probably carries into E6.
- `T-001` opens its S2 run in E10.
- Likely new thread: the Halloween special's unopened chest (E11 → E14).

Names to expect:
- Existing: `blues_letter`, `the_compasses`, `large_luigi`, `davitt`, `ted`.
- Probably new: Plug, the whale, the wraith, Ciaran Silverhowl, *Pack Talks*.

Episode notes:
- **E11:** the special happens after E10 and is made canon in E14. Say so in Lore Notes.
- **E12:** prose = the E13 intro with the answers folded in (DM decision). Lore Notes come from its own transcript.

### S9 · Arc recap (~20 min)
- Exactly three paragraphs under `### Arc recap` in the Arc 2 section of `season2_spine.md`. Written as of E12. At most 2 quotes, each one already verified in a recap.

### S10 · DM line-edit (DM's time)
- Apply the DM's edits without pushback and redraft only what they touch. Quote the approval in the Retro.

### S11 · Review and commit (~15 min)
1. Check the diff for prep notes, future-arc material and `brewed_lore/`.
2. Run the exit check and paste its output into the Retro.
3. Tick E3 in the roadmap.
4. **Ask before committing. Ask separately before pushing** (this would push `7bcd0c7` too).

## Sittings

Plan two sittings of about 3 h each:
- **Sitting 1:** S1 plus E6–E8, with E7 counted double.
- **Sitting 2:** E9–E12, then S9–S11.
- Run `handoff` at the end of sitting 1 and save it to `BarquentineWiki/handoffs/`.

## Skill calls

- `handoff` at the end of each sitting.
- `session-close` is optional, after the commit.
- No `tdd` or `code-review`: no tooling changes are planned.

## Risks

| Risk | Mitigation |
|---|---|
| **Spoiler leakage**: Phthalos's death, Cyan, Manticore | Exit-check greps below. Payoffs stay in `threads.md` |
| **The doc differs from what was read aloud** | S1 step 3. The DM decides any conflict |
| **E7 split cites get confused** | The `P2` prefix |
| **Caption mangling** (Phthalos, Silverhowl, Plug) | `names.md` variants. Flag guesses as *Anomaly* |
| **Unattributable quotes** | Narrate the moment instead |
| **Context size**: about 25k tokens per transcript | Two sittings, and a handoff between them |

## Exit check (run it and paste the output into the Retro)

```bash
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e0[1-9].md BarquentineWiki/sessions/s02e1[0-2].md BarquentineWiki/sessions/s03e*.md; echo "exit=$?"   # s02e34–36 are legacy pipeline files (CLAUDE.md) and stay out
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
ls BarquentineWiki/sessions/s02e0[6-9].md BarquentineWiki/sessions/s02e1[0-2].md | wc -l   # 7
grep -c '^### Arc recap' BarquentineWiki/season2_spine.md                                    # >= 2
grep -n 'Cyan' BarquentineWiki/sessions/s02e0[6-9].md BarquentineWiki/sessions/s02e10.md || echo "no Cyan"   # only E11 and E12 may say Cyan
grep -niE 'manticore' BarquentineWiki/sessions/s02e0[6-9].md BarquentineWiki/sessions/s02e1[01].md   # every hit is Phthalos's name for the ship, not the reveal
git diff --cached | grep -iE 'brewed_lore|prep' || echo "no leaks"
```

## DM decisions during the epic
- 2026-11-06: E7 gets one recap.
- 2026-11-06: the talk-show host is **Ciaran Silverhowl**. The show is *The Pack Talks* (s2 e11 doc).
- 2026-11-06: E12 uses the doc's "E13" intro (read at s02e13 00:01:00). The three player prompts (Room / Lumi / Cyan, "what did you figure out?") get replaced by one narrated sentence per player's live answer, and the "(where?)" aside is dropped. This is a hybrid, so note it in Lore Notes.
- 2026-11-06: DM line-edited s02e06–08: *"is good. i corrected some minor items."*
- 2026-11-06: DM approved s02e09–10: *"9 and 10 are good."*
- 2026-11-06: DM approved s02e11, s02e12 and the arc 2 recap: *"all looks good."*
- 2026-11-06: E11 prose says **Cyan**, since the flash-forward names him so (DM: "a on Cyan"). The exit-check Cyan grep now covers E6–E10.

## Retro (filled at close)

**Exit check output (2026-11-06)**

```
18 recaps OK
exit=0
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 35 ]
7            # s02e06–s02e12 present
2            # arc recaps in season2_spine.md
no Cyan      # E6–E10
manticore    # E7/E8 hits are all Phthalos's name for his ship, not the reveal
6 hits       # leak grep: "preparation"/"prepared" in DM prose and quotes, plus this plan's own rules; no prep notes
```

**DM approval (2026-11-06):** E6–E8 *"is good. i corrected some minor items."* E9–E10 *"9 and 10 are good."* E11, E12 and the arc recap *"all looks good."*

**What happened**
- Two sittings, as planned, with a handoff between them (`BarquentineWiki/handoffs/2026-11-06_e3_sitting1.md`).
- Recaps: E6–E10 use DM intro prose; E11 is generated; E12 is the E13 intro with the three player answers folded in (DM ruling). All seven titles are now ✓ in the spine.
- Ledgers: T-017 (the compasses) closes in s02e12. T-001 opens its S2 run in s02e10. New T-027 (the talk-show chest). New names include `vecna`, `the_incubus`, `coin_of_delving`, `sunken_cavern`, `babau`, `the_wraith`, `ciaran_silverhowl`, `the_pack_talks`. `island_of_bral` first-seen moved to s02e07.
- Cyan: the E11 flash-forward names him Cyan, so its prose does too (DM: "a on Cyan").

**Change in later subplans**
- Scope the exit-check lint to the epic's own files plus S3. The `s02e*` glob catches the legacy s02e34–36 pipeline files, which fail by design until Ez.
- Save intro doc text to the scratchpad *and* note where the intro ends: compressed Drive results (`<<ccr:…>>`) expire before a second sitting, and the scratchpad copy was lost between sittings. Recovering from the session log worked but cost time.
- A flash-forward or special can rename characters early. Check the episode itself before applying a name-timing rule.
