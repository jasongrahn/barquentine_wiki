# E4: Arc 3, Fitting Out — subplan

**First action once approved:** copy this file to `plans/e4_subplan.md`. Then work through the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) runs one epic per arc. E3 (arc 2, Sunken Ship) is done and pushed in `f78b16c`. E4 covers arc 3, **Fitting Out** (`island_of_bral`, s02e13–s02e18, 6 episodes). This is the shore-based arc: the mimic ship and arrival on Bral, Mr. Catastrophe, Cyan leaving, the bone throne, hiring the crew, and Captain Welsh's memory. It closes before Room's dream. The DM checked the arc 3 spine lines: "look good from what i remember." The deliverable is six recaps in `BarquentineWiki/sessions/` plus a three-paragraph arc recap. Each one meets the per-episode DoD.

## Goal

Write `s02e13.md`–`s02e18.md` and the arc 3 recap. Each one passes lint, the VTT grep and the DM's line-edit, and then gets committed.

## Inputs

- **VTTs** (`/Volumes/share/videos/`, all YouTube tier, each `.transcript.vtt`): `Barquentine! S2E13 Chewing Mold`, `S2E14 On a Very Special episode of Blossom`, `S2E15 Hi I'm Ted`, `S2E16 Everyones gunna see me naked`, `S2E17 30-50 Feral Chickens`, `S2E18 Should've used the Field Trip Rope`, plus `S2E19 It's the notes you DONT play`, whose opening recaps E18.
- **No DM intro prose.** Drive search (2026-11-07): the newest S2 per-episode doc is S2E12; there are no S2E13–S2E18 docs. CLAUDE.md confirms that E11–E31 have no intros, so all six recaps are generated.
- **Spelling-only sources, never written into a tracked file:**
  - The S2e14–S2E17 prep tabs in "Barquentine Episode notes" (`1m5xXbEsPBFdTZAUoUAgj6a14I7aF8LcszCmX-r1mBbs`).
  - The "E13" prep section of the S2E12 doc, after "…a call…".
- `season2_spine.md`: the arc 3 lines and **Notes and anomalies** (DM-confirmed spellings: Tiny's Tipsy by the Sea, Captain Welsh, King Bhurgher…). Also `names.md`, `threads.md`, `recap_playbook.md`.
- **Models:** `s02e11.md` for generated prose (four paragraphs ending on the tagline), `s02e09.md` for Lore Notes.
- **Tools:** `tools/vtt_clean.R`, `tools/vgrep.sh`, `tools/lint_recaps.R`.

## Decisions taken (change any at approval)

| Decision | Choice |
|---|---|
| `recorded:` | `~` for all six |
| `source_tier` | `youtube` |
| `recap_prose` | `generated` for all six |
| Prose voice check | Each episode's *player recap* at the top of the next VTT (E18 → the s02e19 opening [Recap s02e19 00:00:00]) is a cross-check for what mattered. It is not the prose source. |
| Titles | E13 and E15 are ✓. E14, E16, E17 and E18 keep the filename title (playbook S2 exception). Tick each one ✓ in the spine once the phrase is heard; if it isn't spoken, note that in Lore Notes. |
| Cyan | Says "Cyan" throughout. He leaves with Vermilion in E14 (T-018), so the E15–E18 prose lists him only if the transcript shows him present. |
| s02e19 opening | Only the E18 recap part is used. The DM's retelling of Room's backstory [VTT s02e19 00:02:03] belongs to arc 4 and stays out. |
| Standing rulings | Normalize name spellings to canon and leave other typos alone. Attribute a quote only when the speaker is unambiguous; otherwise narrate the moment. |
| Arc recap location | A new `### Arc recap` block under the Arc 3 heading in `season2_spine.md` |

## Stories

### S1 · Sources ready (~20 min)
1. Clean s02e14–s02e19 into `cache/transcripts/` (s02e13 is already there).
2. Read the S2e14–S2E17 prep tabs and save a **spelling list only** to the scratchpad (Retro fix: call `headroom_retrieve` right away). Record new caption variants for `names.md`.
- **Check:** `wc -l cache/transcripts/s02e1[3-9].txt` shows 7 files.

### S2–S7 · One recap per episode, E13 → E18 (~45–60 min each)
Run the same loop as E3:
1. Read the whole cleaned transcript, plus the next episode's player-recap opening.
2. Hold the four-persona panel.
3. Write the prose: at most 4 paragraphs, 1–2 quotes, ending on the tagline.
4. Write Lore Notes (every item cited) and Open Threads, written as of the episode, with only a *(SxEy pays off.)* pointer for payoffs.
5. Add names and thread bullets **before** citing them in the frontmatter. Some bullets already exist (`grep -n 's02e1[3-8]' BarquentineWiki/threads.md`): T-001 (E15, E17), T-022 (E13), T-018 (E14), T-011 (E17), T-023 (E18), plus the Abarat/Cyan bullet at line 84.
6. Run `tools/vgrep.sh` on every quote and named event against the **raw** VTT.
7. Run `Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e<NN>.md`.

Thread work to expect:
- **T-027** (the talk-show chest): rewards handed out in E14, which probably closes it.
- **T-018:** Cyan leaves in E14.
- **T-001:** the ship's healing. A throne, platinum and a ritual in E15; the failed sacrifice in E17.
- **T-011:** the captain's door, kicked in during E17.
- **T-014:** Ted's horse? Confirm in E15.

Names to expect:
- Existing: `elder_abarat`, `king_bhurgher`, `bone_throne`, `robert`, `lock`, `stock`, `barrel`, `sirvellica`, `tinys_tipsy`, `captain_welsh`, `silent_jim`, `robe_of_useful_items`.
- Probably new: Mr. Catastrophe (check first), the mimic ship, Vermilion (check first), the young blue dragon. The rest come from the transcripts.

Episode notes:
- **E13:** check first-seen for `elder_abarat` and `king_bhurgher` (both are listed as s02e13).
- **E17/E18:** the Captain Welsh scenes are the Ki-Rin's **past**. Mark them as memory in the prose and Lore Notes.

### S8 · Arc recap (~20 min)
- Exactly three paragraphs under `### Arc recap` in the Arc 3 section of `season2_spine.md`. Written as of E18. At most 2 quotes, each one already verified in a recap.

### S9 · DM line-edit (DM's time)
- Apply the DM's edits without pushback and redraft only what they touch. Quote the approval in the Retro.

### S10 · Review and commit (~15 min)
1. Check the diff for prep notes, future-arc material and `brewed_lore/`.
2. Run the exit check and paste its output into the Retro.
3. Tick E4 in the roadmap (split the "E4…E8" row the way E2 and E3 were split).
4. **Ask before committing. Ask separately before pushing.**

## Sittings

Plan two sittings of about 3 h each:
- **Sitting 1:** S1 plus E13–E15.
- **Sitting 2:** E16–E18, then S8–S10.
- Run `handoff` at the end of sitting 1 and save it to `BarquentineWiki/handoffs/`.

## Skill calls

- `handoff` at the end of each sitting.
- `session-close` is optional, after the commit.
- No `tdd` or `code-review`: no tooling changes are planned.

## Risks

| Risk | Mitigation |
|---|---|
| **Prep leakage** (S2E12 "E13" section, S2e14–17 tabs) | Spelling list only in the scratchpad. Exit-check grep. |
| **Future-arc leakage** (Room's dream, the s02e19 backstory retelling) | Prose written as of its own episode; payoffs stay in `threads.md` |
| **Cyan appears after he leaves** | Exit-check grep on E15–E18; every hit must be backed by the transcript |
| **Memory vs present confusion** (Captain Welsh) | Tag the scenes as the Ki-Rin's past |
| **Caption mangling** (Bhurgher, Sirvellica, Abarat) | `names.md` variants. Flag guesses as *Anomaly* |
| **Context size**: about 25k tokens per transcript | Two sittings, and a handoff between them |

## Exit check (run it and paste the output into the Retro)

```bash
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e0[1-9].md BarquentineWiki/sessions/s02e1[0-8].md BarquentineWiki/sessions/s03e*.md; echo "exit=$?"   # s02e34–36 stay out (legacy)
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
ls BarquentineWiki/sessions/s02e1[3-8].md | wc -l                                  # 6
/usr/bin/grep -c '^### Arc recap' BarquentineWiki/season2_spine.md                 # >= 3
/usr/bin/grep -n 'Cyan' BarquentineWiki/sessions/s02e1[5-8].md || echo "no Cyan"   # each hit backed by the transcript
/usr/bin/grep -niE 'dream|president mario|vampirate' BarquentineWiki/sessions/s02e1[3-8].md || echo "no arc 4"
git diff --cached | /usr/bin/grep -iE 'brewed_lore|prep|fog|gate plan' || echo "no leaks"
```

## DM decisions during the epic
- 2026-11-06: arc 3 spine lines "look good from what i remember."
- 2026-11-07: DM approved s02e13: *"good."* (Kept: E13 opens T-004; the S2E11-timing anomaly is flagged in Lore Notes, spine untouched; no `billow` slug.)
- 2026-11-07: DM approved s02e14: *"good."* (Kept: Hoovale spelling, T-027 closed in E14, title unspoken under the S2 exception.)
- 2026-11-07: DM on s02e15: the bookstore is **Bards and Nobles**; **Furrizon Wireless** is correct (named in an earlier episode). Added `bards_and_nobles` and cited it in s02e13 and s02e15; both spellings added to the playbook.
- 2026-11-07: DM approved s02e15: *"good."* Sitting 1 continues into E16.
- 2026-11-07: DM approved s02e16: *"good."* (Kept: the throne-price anomaly in Lore Notes; crew counted 12 of 12.)
- 2026-11-13: DM approved s02e17: *"otherwise good."* Shipwrights are **Centaury 21** (centaur pun; slug renamed `century_21` → `centaury_21` in s02e16, s02e17, names.md, playbook). "BS & Noble" is the Bards and Nobles bookstore joke; the s02e17 quote now names the store and keeps the caption in parentheses. (Kept: generated `recap_prose`, title unspoken.)
- 2026-11-13: DM on s02e18: the name is **Bhurgher**, not Burger. Renamed `king_buhrghur` → `king_bhurgher` and Buhrghur → Bhurgher in s02e13, s02e18, names.md, threads.md, the spine and the playbook; caption variants kept in names.md.
- 2026-11-14: DM on s02e18: Basil's alias is **Rex**; the fish-person sheriff is the **Cofishioner** (commissioner + fish); the half-lobster is "perhaps" Robert's kind, the **trobster**; the platinum chest is `ancient_coins`; Captain Bhurgher stays Basil's suspicion. Added `the_cofishioner`; Robert's row gains the trobster variants; playbook spellings updated.
- 2026-11-14: DM on the arc 3 recap: Lucy was one battle, not glued to the hull for the trip; first sentence redrafted. DM approved s02e18 and the arc recap: *"otherwise, approve & commit. I really like the style / fields we're developing."*

## Retro (filled at close)

**Exit check output (2026-11-14)**

```
24 recaps OK
exit=0
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 35 ]
6            # s02e13–s02e18 present
3            # arc recaps in season2_spine.md
2 hits       # Cyan in E15–E18: both s02e15 lines say he's gone; backed by transcript
5 hits       # arc 4 grep: all "dream" setup in E13 and the Baku nursery rhyme in E15; no President Mario, no vampirates
leak grep    # hits are in-session Veil of Mist "fog" lines, s02e17 citing the prep-tab opening the DM read aloud, and this plan's own rules; the one prep-content summary in Inputs was cut before commit
```

**DM approval:** E13–E16 *"good."* (2026-11-07). E17 *"otherwise good."* (2026-11-13). E18 and the arc recap *"otherwise, approve & commit. I really like the style / fields we're developing."* (2026-11-14).

**What happened**
- Three sittings, not two: E13–E16 on 2026-11-07, E17 drafted 2026-11-08, then the DM's E17 edits, E18 and the arc recap on 2026-11-13/14.
- All six recaps are generated (no DM intro prose for E13–E18). E13 and E15 titles are ✓; E14, E16–E18 keep the filename title under the S2 exception.
- DM spelling rulings: Bards and Nobles, Furrizon Wireless, Centaury 21 (slug renamed), King Bhurgher (slug renamed from `king_buhrghur`), the Cofishioner, trobster, Rex.
- E17/E18 Captain Welsh scenes are tagged as the Ki-Rin's past in prose and Lore Notes.
- New names include `old_zealand`, `young_blue_dragon`, `the_cofishioner`, `centaury_21`, `douglas`; `ancient_coins` first-seen moved to s02e18 (DM: same chest).

**Change in later subplans**
- Pun names (Centaury 21, Bhurgher, Cofishioner) look like caption errors. List likely puns in the DM-call section of each draft instead of normalizing them to the real-world spelling.
- Attribute history and knowledge checks by who the DM addresses (e.g. "your cloister" = Lumi), not by who spoke last; E18's coin scene was first misattributed to Room.
- In the Inputs list, name prep sources without summarizing their contents, so the leak grep only hits rules.
- `tools/vgrep.sh` misses quotes split across caption cues; the awk time-window from the E4 handoff was the reliable fallback.
