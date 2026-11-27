# E6: Arc 5, The Rock — subplan

**First action once approved:** start S1. Then work through the stories in order.

## Context

The S2 backfill roadmap (`plans/s2_backfill_roadmap.md`) runs one epic per arc. E5 (arc 4, The Recipe Heist) is merged in PR #3 (`06621d6`). E6 covers arc 5, **The Rock** (`the_rock`, s02e23–s02e30, 8 episodes). The arc runs from the ritual's aftermath and the ship rising into space, through the voyage to the Rock and the crew's business there, to shoving off from the Rock at the end of s02e30. It stops before the slaad passengers (arc 6). The deliverable is eight full recaps and a three-paragraph arc recap. Each recap meets the per-episode DoD.

## Goal

Write `s02e23.md`–`s02e30.md` and the arc 5 recap. Each one passes lint, the VTT grep and the DM's line-edit, and then gets committed.

## Inputs

- **VTTs** (`/Volumes/share/videos/`, all YouTube tier, each `.transcript.vtt`): `Barquentine! S2E23 The wind in your hair` through `S2E30 To Be 16 Again`, all present. `S2E31 Someone Forgot to Knock` opens with the E30 recap; only that part is used.
- **Fallback audio:** every episode's recording is in `/Volumes/share/videos/published/` (`.mkv`; E30 is `.mp4`). Use the E5 Whisper method only if a VTT turns out bad.
- **No DM intro prose.** CLAUDE.md: E11–E31 have no intros. All eight recaps are generated.
- **Prep tabs S2E25 and s2e26** in "Barquentine Episode notes": spelling checks only. Never quote or summarize them here or in a recap.
- `season2_spine.md`: the arc 5 lines and **Notes and anomalies**. Also `names.md`, `threads.md`, `recap_playbook.md`.
- **Models:** `s02e22.md` for generated prose and Lore Notes (newest DM-approved style).
- **Tools:** `tools/vtt_clean.R`, `tools/vgrep.sh`, `tools/lint_recaps.R`.

## DM decisions at approval (2026-11-19)

| Question | Answer |
|---|---|
| E29 *Snatch Interlude* framing | **Canon, from the trio's point of view.** Write it like any episode. One opening line names it as a side adventure with the players as Lock, Stock and Barrel. |
| s02e23 opening (ritual's cost, throne welded to deck, ship rises) | **Opens arc 5**, as the spine says. s02e23's recap starts there. |
| Sittings | **3-3-2 plus arc recap** (see Sittings). |
| Subagents | **Two reviewers, no drafting swarm.** `editor` (read-only: quotes, attribution, style, spoilers) and `archivist` (**owns `names.md` and `threads.md`**, continuity, dangling threads). The main agent drafts and stays the only writer of recaps and the spine. |
| Thread-status script | **No.** The archivist judges dangling threads itself. |
| Agent files | **Local only.** `.claude/agents/{editor,archivist}.md`, gitignored. |

## Defaults carried from E5 (change any at approval)

| Item | Choice |
|---|---|
| `recorded:` | `~` for all eight |
| `source_tier` | `youtube` for all eight |
| `recap_prose` | `generated` for all eight |
| Prose voice check | The player recap at the top of the next VTT is a cross-check for what mattered, not the prose source. E30 → [Recap s02e31 00:00:03]. |
| Titles | E23 and E27 are ✓. The rest keep the filename title (S2 exception); tick ✓ in the spine if the phrase is heard. |
| Spine lines | Rewrite each arc 5 spine line from its recap once drafted. |
| s02e31 opening | Only the E30 recap part is used. The slaad passengers and Sirvellica's magic furniture belong to arc 6 and stay out. |
| Standing rulings | Normalize name spellings to canon and leave other typos alone. Attribute a quote only when the speaker is unambiguous; otherwise narrate the moment. |
| Arc recap location | A new `### Arc recap` block under the Arc 5 heading in `season2_spine.md` |

## Lessons carried from the E4 and E5 Retros

1. **Pun names:** names that look like caption errors may be DM puns (memory `dm_pun_names`). Flag them in the draft's question batch; don't normalize. Watch: the space clowns, Ledger, the Conclave, Supper Nova, King Bhurgher.
2. **Attribution:** attribute history and knowledge checks by who the DM addresses, not by who spoke last.
3. **Questions:** every decision and every "who is this?" call goes to the DM as an AskUserQuestion with options, alongside spellings, with the draft.
4. **Quote check:** if `tools/vgrep.sh` misses, use the awk time-window fallback before declaring a quote unverified.
5. **Arc-leak grep:** use word boundaries (`moth` matched "mother's" in E5).

## Stories

### S1 · Sources ready (~15 min)
1. Clean s02e24–s02e31 into `cache/transcripts/` (s02e23 is already there).
- **Check:** `ls cache/transcripts/s02e2[3-9].txt cache/transcripts/s02e3[01].txt | wc -l` prints 9.
2. **Archivist baseline sweep** (~10 min): run the `archivist` sweep job over all existing recaps. Paste its dangling, closeable and orphan lists into the hand-off. Ledger fixes it proposes beyond typos go to the DM first.

### S2–S9 · s02e23 … s02e30 (~55–75 min each)
Run the per-episode loop for each:
1. Read the whole cleaned transcript, plus the next episode's opening for anything that touches it.
2. Hold the four-persona panel.
3. Write the prose: at most 4 paragraphs, 1–2 quotes, ending on the tagline.
4. Write Lore Notes (every item cited), Open Threads (as of the episode, with only a *(SxEy pays off.)* pointer for payoffs) and the frontmatter.
5. Run the self-check: `tools/vgrep.sh` on every quote and named event against the **raw** VTT.
6. **Review, both agents in parallel:**
   - `editor`: recap path, raw VTT path, cleaned transcript, the DM rulings so far.
   - `archivist`: recap path. It adds names and thread bullets, then runs lint.
7. Apply editor findings and archivist recap fixes. Re-run lint until it exits 0.
8. Hand the draft to the DM with one question batch (spellings, puns, "who is this?", proposed threads, archivist continuity flags).

Thread work to expect (check `threads.md` first; add bullets only where an episode advances one):
- T-001 hungry ship (the ship healing where someone died), T-021 Ted Two, T-022 Mr. Catastrophe.
- T-015 the Captain's parents and T-016 the Captain's lost name (Ledger).
- T-004 Room's map, T-005 and T-009 (Eberron), T-023 King Bhurgher, T-020 the rain cloud.
- Ledger probably opens a thread. Propose it in the question batch; don't add it unasked.

Names to expect:
- Existing: `the_rock`, `bone_throne`, `astral_elves`, `ledger`, `ted_two`, `space_clowns`, `eberron`, `the_conclave`, `supper_nova`, `king_bhurgher`, `lock`, `stock`, `barrel`, `sirvellica`, `mr_catastrophe`.
- Probably new: the moth-shaped ship, the derelict, the mind-flayer ship, Ledger's bar. The rest come from the transcripts.

### S10 · Arc recap (~30 min)
- Exactly three paragraphs under `### Arc recap` in the Arc 5 section of `season2_spine.md`. Written as of E30. At most 2 quotes, each one already verified in a recap.
- Run an `archivist` sweep scoped to arc 5: which threads opened, which closed, and which are left dangling at the arc's end. Hand that list to the DM with the arc recap.

### S11 · DM line-edit (DM's time)
- Apply the DM's edits without pushback and redraft only what they touch. Quote the approval in the Retro.

### S12 · Review and commit (~15 min)
1. Check the diff for `brewed_lore/` and arc 6 material.
2. Run the exit check and paste its output into the Retro.
3. Tick E6 in the roadmap.
4. **Ask before committing. Ask separately before pushing.** Open a PR; the DM merges.

## Sittings

- **Sitting 1 (~3.5 h):** S1 (with the baseline sweep), E23, E24, E25.
- **Sitting 2 (~3.5 h):** E26, E27, E28.
- **Sitting 3 (~3 h):** E29, E30, then S10–S12.
- Run `handoff` at the end of sittings 1 and 2 and save it to `BarquentineWiki/handoffs/`.

## Skill calls

- `handoff` at the end of sittings 1 and 2.
- `session-close` is optional, after the commit.
- No `tdd` or `code-review`: no tooling changes are planned.

## Risks

| Risk | Mitigation |
|---|---|
| **Arc 6 leakage** (slaad, the infection, the Astral Plane voyage) from the s02e31 opening | Use only the E30 part of that opening. Exit-check grep with word boundaries. |
| **E29 side adventure written as a lesser episode** | DM ruling: canon, trio's point of view, one framing line. |
| **Pun names flattened by captions** | Flag in each draft's question batch; never normalize silently |
| **No speaker labels** (YouTube tier) | Attribute only when unambiguous; narrate otherwise |
| **Context size**: about 20–30k tokens per transcript | Three sittings, a handoff after each of the first two |

## Exit check (run it and paste the output into the Retro)

```bash
Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/s02e0[1-9].md BarquentineWiki/sessions/s02e1[0-9].md BarquentineWiki/sessions/s02e2[0-9].md BarquentineWiki/sessions/s02e30.md BarquentineWiki/sessions/s03e*.md; echo "exit=$?"   # s02e34–36 stay out (legacy)
Rscript --vanilla -e 'testthat::test_dir("tools/tests")'
ls BarquentineWiki/sessions/s02e2[3-9].md BarquentineWiki/sessions/s02e30.md | wc -l   # 8
/usr/bin/grep -c '^### Arc recap' BarquentineWiki/season2_spine.md                     # >= 5
/usr/bin/grep -niwE 'slaad|slaadi|modrons?|flotilla|infection|froglike' BarquentineWiki/sessions/s02e2[3-9].md BarquentineWiki/sessions/s02e30.md || echo "no arc 6"   # each hit backed by the transcript
git diff --cached | /usr/bin/grep -iE 'brewed_lore' || echo "no leaks"
```

## DM decisions during the epic
- 2026-11-19: E29 is canon from the trio's point of view; the s02e23 opening opens arc 5; sittings split 3-3-2 plus arc recap.
- 2026-11-23: plan approved. Added the `editor` and `archivist` subagents as reviewers (no drafting swarm). The archivist owns the ledgers; no thread-status script; agent files stay local and gitignored.
- 2026-11-24: baseline sweep rulings. s03e01–03 frontmatter fixed (S2-born threads moved from `threads_opened` to `threads_advanced`). T-018 is **dormant**, kept open. New optional `factions:` frontmatter key: lint + 2 tests (40/40 pass), playbook schema line, backfilled in s02e19, s02e20, s02e22. Arc 5 recaps cite `astral_elves`, `space_clowns` etc. there.
- 2026-11-24: s02e23 rulings. loxodon (not "lockxodon"); Ricky stands (`ricky`); "Ted Pillow" is Billow; `barnacle_bess` added; the read-aloud "moon dancer" note cut.
- 2026-11-24: s02e24 rulings. T-021 Ted Two opens at s02e25; keep `mr_cream`, `star_moth`, `rod_of_the_pact_keeper`, `terillian_corn_cob`; new thread **T-029 Mr. Cream** (opens s02e13).
- 2026-11-24: s02e25 rulings. T-016 keeps opening at s02e27; Basil's second name is **Falstaff**; Christopher's healer brother is **Heem**; Mr. Cream's alias is **Commandant Cream**. `eberron` not cited before s02e26 (the Marble = Eberron is only a player guess there).
- 2026-11-24: sitting 1 ends. s02e23–s02e25 drafted, reviewed (editor + archivist) and lint-clean, awaiting DM line-edit. Handoff: `BarquentineWiki/handoffs/2026-11-24_e6_sitting1.md`.
- 2026-11-24: final `editor` pass on s02e23–s02e25 (12 small fixes applied). DM approved s02e23 ("23 good").
- 2026-11-24: **prose length cap: about 350 words, 400 max** for generated recaps (playbook + editor check). s02e23–s02e25 trimmed to fit; s02e23 needs re-approval. Trimming s02e11–s02e22 deferred (roadmap "Later").
- 2026-11-24: DM approved the trimmed s02e23 and s02e24 ("23 and 24 good").
- 2026-11-24: s02e25 name bargain reworded to match the VTT (Basil had already said his first name; the Ledger accepts it). DM approved s02e25 ("25 good"). Sitting 1 complete.
- 2026-11-24: **accuracy tooling** (DM: quotes and summaries must be exact). (1) Playbook + editor rule: quote deals, bargains, rulings and rolls as the full exchange. (2) `tools/vtt_clean.R` blocks shrunk from 60 s to 10 s (test updated); s02e23–s02e31 re-cleaned. (3) New `tools/cite_check.R` (17 tests, suite 57/57): checks every italic quote and `[VTT]` citation against the raw VTT; documented in CLAUDE.md and the editor's first check. It caught two misses the editor didn't (s02e23 astral-sea cite 38 s off; s02e24 cross-episode cite); both fixed, and the s02e23 "moon dancer" cut re-applied. s02e23–25 now 0 off / 0 missing. (4) Project skill `.claude/skills/vtt-quote/`.
- 2026-11-24: sitting 2 starts. s02e26–s02e28 drafted, cite_check clean, editor + archivist reviewed. s02e26 rulings: title ✓ ("down greased uh next to a clown"); `gnome_depot` is a faction; new thread **T-030 Legs for the ship** (s02e26 → s03e02); `captain_zyra` slug; T-013 gets an s02e26 bullet (Marble question). Declined: T-021 s02e26 bullet; s02e15 "war on neon" fix.
- 2026-11-24: s02e27/s02e28 rulings. Frog-folk passengers board in s02e28: T-024 gets an s02e28 bullet, but no `slaadi` slug before s02e31 and arc 6 still starts at s02e31. "Nigel" is a player riff. The s02e28 giant moth is not the star moth. Lumi's "Captain Hamburg" retelling goes in s02e28 (T-023). No "Manny" variant. T-016 keeps opening at s02e27.
- 2026-11-24: T-024's first bullet is now s02e28, so s02e28 has `threads_opened: [T-024]`. **When s02e31 is recapped (arc 6), cite T-024 in `threads_advanced`, not `threads_opened`.** Ledger complete for s02e26–s02e28; lint 4/4 OK (incl. s03e02 closing T-030).
- 2026-11-25: DM approved s02e26, s02e27 and s02e28 ("26, 27, and 28 all look good"). Sitting 2 complete. Still open: canonical spelling of Basil's full name (s02e27 caption: "False Staff Asparro Palonius. Boric Basanio Melville").
- 2026-11-26: sitting 3. s02e29 and s02e30 drafted, cite_check clean, editor + archivist reviewed; arc 5 recap drafted in the spine; arc 5 sweep run. Rulings: General Theodore (s02e29) is the S3E1 merchant, **kept secret** (split 2026-11-27: `general_theodore` for s02e29, `theodore` stays the S3E1 merchant, since a shared slug would itself state the link). Stock's cover name is **Captain Stock of the Cantamore**; the trio's self-declared generalships and captaincies are logged in s02e29 Lore Notes and names.md. s02e30 advances **T-016** (Lumi can't recall the Captain's name). Basil's full first name, provisional: **Basil Falstaff Prospero Palonius Basanio Melville** (DM asking the player for notes). Sweep fixes: missing slugs added to s02e23/27/28 frontmatter; arc recap drops "real" Mr. Catastrophe, "beheaded mind flayers" and "rival" captain.

## Retro (filled at close)

**Exit check output (2026-11-27)**

```
37 recaps OK
exit=0
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 57 ]
8            # s02e23–s02e30 present
5            # arc recaps in season2_spine.md
10 hits      # arc 6 grep: 9 are the Giff Flotilla named as a destination/trial in E25 and E27 (transcript-backed, set up in arc 5); 1 is "froglike" in E28 (the DM's description of the passengers); no slaad, modron or infection
leak grep    # the only hit is the .gitignore line excluding brewed_lore/; no recap mentions it. Re-run on the staged diff before commit.
```

**DM approval:** E23 and E24 *"23 and 24 good."* E25 *"25 good."* E26–E28 *"26, 27, and 28 all look good."* E29, E30 and the arc recap *"approved"* (2026-11-27).

**What happened**
- Three sittings (2026-11-24, 11-24/25, 11-26/27) after the subplan was approved on 2026-11-19.
- All eight recaps are generated. s02e29 is written from Lock, Stock and Barrel's point of view, opening with one line naming it a side adventure.
- New tooling mid-epic: 10 s cleaner blocks, `tools/cite_check.R` (17 tests), the `vtt-quote` skill, and a 350/400-word prose cap.
- One new thread (T-030 Legs for the ship). T-016 now advances in s02e30. Theodore's S3E1 identity stays secret.
- The DM caught a patron's question ("necromancer") stated as fact in s02e30 Open Threads; the final open-ended editor pass found 10 more errors in E29/E30/the arc recap.

**Change in later subplans**
- Editor briefs are open-ended ("review this recap against the VTT and playbook"). Never hand the editor a list of my own suspicions; it then checks only those.
- Any text edited after an editor pass gets a second editor pass before it goes to the DM.
- The arc recap gets its own editor pass, checking chronology against the episode recaps.
- An NPC's question, rumor or boast is reported as theirs ("the Rock's captains have heard…"), never as fact.
- Count prose words including the H1, as the editor does; leave a 10-word margin under 400.
