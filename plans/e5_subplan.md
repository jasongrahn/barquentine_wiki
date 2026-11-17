# E5: Arc 4, The Recipe Heist — subplan

**First action once approved:** start S1. Then work through the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) runs one epic per arc. E4 (arc 3, Fitting Out) is done and pushed in `fa00fc0`. E5 covers arc 4, **The Recipe Heist** (`rooms_dream`, s02e19–s02e22, 4 episodes). The whole arc happens inside Room's dream: President Mario's secret recipe, the vampirate compound, Periwinkle, the dial door, the small dragon, the double-cross and the void-sludge escape. It closes before the ship rises into space (arc 5). s02e20 has no transcript. The deliverable is three full recaps, one E20 stub and a three-paragraph arc recap. Each recap meets the per-episode DoD.

## Goal

Write `s02e19.md`–`s02e22.md` and the arc 4 recap. Each one passes lint, the VTT grep and the DM's line-edit, and then gets committed.

## Inputs

- **VTTs** (`/Volumes/share/videos/`, all YouTube tier, each `.transcript.vtt`): `Barquentine! S2E19 It's the notes you DONT play`, `S2E21 This is no big deal, right`, `S2E22 Hair on Edge`, plus `S2E23 The wind in your hair`, whose opening recaps E22. No S2E20 file.
- **No DM intro prose.** CLAUDE.md: E11–E31 have no intros, and the per-episode Drive docs stop at S2E12. All recaps are generated.
- **No prep sources for this arc.** The listed prep tabs (S2e14–S2E17, S2E25, s2e26, s2e32, "Tab 7") are out of scope. Spellings come from `names.md`, the captions and the DM.
- `season2_spine.md`: the arc 4 lines and **Notes and anomalies**. Also `names.md`, `threads.md`, `recap_playbook.md`.
- **Models:** `s02e18.md` for generated prose and Lore Notes (newest DM-approved style).
- **Tools:** `tools/vtt_clean.R`, `tools/vgrep.sh`, `tools/lint_recaps.R`.

## Decisions taken (change any at approval)

| Decision | Choice |
|---|---|
| `recorded:` | `~` for all four |
| `source_tier` | `youtube` for E19, E21, E22; `whisper` for E20 (tier added to the lint 2026-11-17) |
| `recap_prose` | `generated` for all four |
| **E20** | **Full recap** from a Whisper transcript of the NAS recording (superseded the stub plan 2026-11-17). Transcript saved to the NAS as `Barquentine! S2E20 Hot Hands.whisper.vtt`. |
| E20 title | **"Hot Hands"** (DM, 2026-11-15). Update the spine line's "—" to match. |
| Prose voice check | Each episode's player recap at the top of the next VTT is a cross-check for what mattered, not the prose source. E22 → [Recap s02e23 00:00:02]. |
| Titles | E21 and E22 are ✓. E19 keeps the filename title (S2 exception); tick ✓ in the spine if the phrase is heard. |
| s02e19 opening | The E18 player recap stays out. The DM's retelling of Room's backstory [VTT s02e19 00:02:03] is arc 4 material and can be used. |
| s02e23 opening | Only the E22 recap part is used. Mr. Catastrophe, the ritual and the ship rising belong to arc 5 and stay out. |
| Dream framing | These are **canon events that take place within a forced dream sequence** (DM, 2026-11-15). Write them as canon. Name the setting as Room's dream; don't add "dream-only" caveats. |
| Standing rulings | Normalize name spellings to canon and leave other typos alone. Attribute a quote only when the speaker is unambiguous; otherwise narrate the moment. |
| Arc recap location | A new `### Arc recap` block under the Arc 4 heading in `season2_spine.md` |

## Lessons carried from the E4 Retro

1. **Pun names:** names that look like caption errors may be DM puns (memory `dm_pun_names`). List likely puns in a *DM calls* section of each draft hand-off. Don't normalize them to the real-world spelling. Watch: President Mario, Periwinkle, the vampirates.
2. **Attribution:** attribute history and knowledge checks by who the DM addresses, not by who spoke last.
3. **No prep summaries in plans:** name sources, never summarize their contents.
4. **Quote check:** if `tools/vgrep.sh` misses, use the awk time-window fallback from the handoff before declaring a quote unverified.

## Stories

### S1 · Sources ready (~10 min)
1. Clean s02e21, s02e22 and s02e23 into `cache/transcripts/` (s02e19 is already there).
- **Check:** `ls cache/transcripts/s02e19.txt cache/transcripts/s02e2[1-3].txt` shows 4 files.

### S2 · s02e19 (~45–60 min)
Run the per-episode loop:
1. Read the whole cleaned transcript, plus the s02e21 opening for anything that touches E19.
2. Hold the four-persona panel.
3. Write the prose: at most 4 paragraphs, 1–2 quotes, ending on the tagline.
4. Write Lore Notes (every item cited) and Open Threads, as of the episode, with only a *(SxEy pays off.)* pointer for payoffs.
5. Add names and thread bullets **before** citing them in the frontmatter.
6. Run `tools/vgrep.sh` on every quote and named event against the **raw** VTT.
7. Run `Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e19.md`.

### S3 · s02e20 (done: full recap from the Whisper transcript)
- Superseded 2026-11-17: transcribed the NAS recording and ran the S2 loop.

### S4–S5 · s02e21, s02e22 (~45–60 min each)
- Same loop as S2. E22's cross-check is the s02e23 opening.

Thread work to expect:
- The `rooms_dream` thread (threads.md lines 38 and 47): bullets exist for s02e19 and s02e22. Add E20/E21 bullets if they advance it.
- Periwinkle's double-cross (E22) probably opens a thread. Check `threads.md` first.
- The recipe itself: delivered to President Mario, or carried out? Check E22.

Names to expect:
- Existing: `president_mario`, `periwinkle`, `room_map`, `rooms_dream`, `vampirate_compound`, `vampirates`.
- Probably new: the small dragon in the nest, the void-sludge monster, the secret recipe, the dial/laser door. The rest come from the transcripts.

### S6 · Arc recap (~20 min)
- Exactly three paragraphs under `### Arc recap` in the Arc 4 section of `season2_spine.md`. Written as of E22. At most 2 quotes, each one already verified in a recap. E20 events cited to the player recap.

### S7 · DM line-edit (DM's time)
- Apply the DM's edits without pushback and redraft only what they touch. Quote the approval in the Retro.

### S8 · Review and commit (~15 min)
1. Check the diff for `brewed_lore/` and arc 5 material.
2. Run the exit check and paste its output into the Retro.
3. Tick E5 in the roadmap.
4. **Ask before committing. Ask separately before pushing.**

## Sittings

- **Sitting 1 (~3 h):** S1, E19, E20 stub, E21.
- **Sitting 2 (~2 h):** E22, then S6–S8.
- Run `handoff` at the end of sitting 1 and save it to `BarquentineWiki/handoffs/`.

## Skill calls

- `handoff` at the end of each sitting.
- `session-close` is optional, after the commit.
- No `tdd` or `code-review`: no tooling changes are planned.

## Risks

| Risk | Mitigation |
|---|---|
| **Whisper errors** in E20: no speaker labels or turns, mangled names | Every quote checked against the Whisper VTT; name guesses flagged as *Anomaly* |
| **Arc 5 leakage** (Mr. Catastrophe's ritual, the ship rising, the Rock) from the s02e23 opening | Use only the E22 part of that opening. Exit-check grep. |
| **Dream events written as non-canon** | DM ruling: canon events in a forced dream. No hedging caveats |
| **Pun names flattened by captions** | *DM calls* list in each hand-off; never normalize silently |
| **Context size**: about 20k tokens per transcript | Two sittings, and a handoff between them |

## Exit check (run it and paste the output into the Retro)

```bash
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e0[1-9].md BarquentineWiki/sessions/s02e1[0-9].md BarquentineWiki/sessions/s02e2[0-2].md BarquentineWiki/sessions/s03e*.md; echo "exit=$?"   # s02e34–36 stay out (legacy)
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
ls BarquentineWiki/sessions/s02e19.md BarquentineWiki/sessions/s02e2[0-2].md | wc -l   # 4
/usr/bin/grep -c '^### Arc recap' BarquentineWiki/season2_spine.md                     # >= 4
/usr/bin/grep -niE 'catastrophe|welded|the rock|astral|moth' BarquentineWiki/sessions/s02e19.md BarquentineWiki/sessions/s02e2[0-2].md || echo "no arc 5"   # Mr. Catastrophe is from arc 3; each hit backed by the transcript
git diff --cached | /usr/bin/grep -iE 'brewed_lore' || echo "no leaks"
```

## DM decisions during the epic
- 2026-11-15: s02e20 is titled **"Hot Hands"**.
- 2026-11-15: E20 gets a stub plus one paragraph from [Recap s02e21]. The s02e19 Room backstory retelling goes in E19. Arc 4 events are "canon events that take place within a _forced_ dream sequence."
- 2026-11-17: s02e19 rulings: "Lodge Luigi" is Large Luigi (caption error); the dohwar is **Gene**, not Jean; Lumi is quartermaster; the ship is **The Raft**.
- 2026-11-17: DM approved s02e19 ("19 is good"). E20 stub replaced: no YouTube captions, so audio from the NAS `published/Barquentine! S2E20 Hot Hands.mkv` was transcribed with mlx-whisper large-v3-turbo. Run 1 looped ("The." from 00:40 on); run 2 used `--condition-on-previous-text False --hallucination-silence-threshold 2 --word-timestamps True` and is clean.
- 2026-11-17: DM approved s02e20 ("everything looks good for e20 based on what we had available"). Added a `whisper` source_tier to the lint (with a test); copied the Whisper VTT to the NAS.
- 2026-11-17: s02e21 drafted (awaiting DM line-edit). New slugs `young_lunar_dragon` (named "lunar dragon" at [VTT s02e21 01:44:45]) and `fey_spirit`. Spine lines for E20 and E21 rewritten from the recaps. Sitting 1 ends here.
- 2026-11-17: DM approved s02e21 ("looks good"). "Lunar dragon" is canon (a D&D 5e monster); "fey" is the correct spelling.
- 2026-11-17: s02e22 drafted (awaiting DM line-edit). New slugs `draconic_spirit`, `the_heartless`, `void_sludge_monster`; the dragon's name added to `young_lunar_dragon` as "Calisterics" (DM confirmed). Bullets on T-003, T-004 and T-010. The skeleton's old T-004 bullet "they escape the dream with the recipe" was merged into the new one. No new thread for Periwinkle (DM). DM: the woman on the Heartless is Dread Captain Yi and the dohwar is Periwinkle.

## Retro (filled at close)

**Exit check output (2026-11-17)**

```
28 recaps OK
exit=0
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 36 ]
4            # s02e19–s02e22 present
4            # arc recaps in season2_spine.md
7 hits       # arc 5 grep: 5 are Mr. Catastrophe in E19 (his dream plan, arc 3 carry-over, transcript-backed); 2 are "mother's necklace" in E22 (false match on "moth"); no Rock, astral or welding
leak grep    # nothing staged yet; working diff and new recaps have no brewed_lore hits. Re-run on the staged diff before commit.
```

**DM approval:** E19 *"19 good."* E20 *"everything looks good for e20 based on what we had avaialble to use."* E21 *"looks good."* E22 and the arc recap *"E22 and arc recap approved."* (all 2026-11-17).

**What happened**
- Two sittings as planned, both on 2026-11-17 after the subplan was approved on 2026-11-15.
- **E20 had no captions.** The stub plan was dropped. mlx-whisper (large-v3-turbo) transcribed the NAS recording. The run looped on "The." until it was re-run with `--condition-on-previous-text False --hallucination-silence-threshold 2`. A new `whisper` source_tier went into the lint with a test, and the VTT was copied to the NAS.
- All four recaps are generated. E19 keeps its filename title; E20, E21 and E22 titles are spoken (✓).
- DM rulings: Large Luigi ("Lodge Luigi" caption), Gene, the Raft, Lumi as quartermaster, "Hot Hands", lunar dragon (canon 5e), fey, Calisterics, and naming Captain Yi and Periwinkle on the Heartless's bow even though the narration doesn't.
- New names include `cloak_of_the_bat`, `platinum_hook`, `young_lunar_dragon`, `fey_spirit`, `draconic_spirit`, `the_heartless`, `void_sludge_monster`. No new threads. Bullets were added to T-003, T-004, T-010 and T-022.

**Change in later subplans**
- Before planning a stub, check the NAS `published/` folder for the episode's recording. A missing VTT doesn't mean a missing source.
- Pose every decision as a question (AskUserQuestion with options), not as a "Decisions" list the DM has to read as questions.
- "Who is this?" calls (unnamed figures, DM-ruled identities) go in the question batch with the draft, alongside spellings.
- Exit-check arc greps need word boundaries: `moth` matched "mother's".
