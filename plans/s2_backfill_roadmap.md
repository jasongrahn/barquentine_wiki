# Season 2 recap backfill: roadmap

**This plan's only action on approval:** copy this roadmap to `~/R-projects/barquentine_wiki/plans/s2_backfill_roadmap.md`. Nothing else gets built. Each epic below gets its own subplan, written in plan mode, before any work on it starts.

---

## Context

S3E1–S3E6 recaps are done (`BarquentineWiki/sessions/`). The goal is a recap library covering all of S2 that makes old setups easy to find when they pay off ("reminders of days gone by"). At 48+ episodes, prose alone can't do that. Each recap also gets structured frontmatter, and a threads ledger tracks storylines across episodes.

**Sources:**
- **Zoom tier, S2E34–S2E43.** `GMT…_Recording.transcript.vtt`, speaker-labeled. Confirmed: GMT20251223 = E34, 0113 = E35, 0127 = E36. E37–E43 = the next 7 GMT files by date (to verify).
- **YouTube tier, S2E1–S2E33.** `Barquentine! S2E….transcript.vtt`: auto-captions, no speaker labels, `[ __ ]` censoring. Each opens with the DM's "Previously on."
- **Gaps:** S2E20 has no transcript. S2E7 is split into Part 1 and Part 2. The descriptive-name S2E34 file is a YouTube duplicate, so the Zoom copy wins.
- **DM intros:** Google Doc "Barquentine Episode notes" (`1m5xXbEsPBFdTZAUoUAgj6a14I7aF8LcszCmX-r1mBbs`) has intros s2e33 through s2e43. Each "s2eN intro" recaps S2E(N−1), so E32–E42 already have DM prose. The same doc has DM prep notes for E14–17, 25, 26, 32. Those are a plan, not canon, but useful for spelling names.
- **Old S2E34–36 pipeline files:** keep their entity-list frontmatter idea. Replace the rest.

**Decisions made:**
- **Order:** spine first, then fill backwards from S2E42 (more on this below).
- **Callbacks:** frontmatter plus a threads ledger.
- **Spoilers:** each recap's prose is written as of its own episode. Payoffs appear only in `threads.md` and in a one-line "Pays off:" under Open Threads.

**Why spine first:** Pass 1 reads only the opening "Previously on" segment of every S2 VTT, which is the DM's own voice. That yields a full season outline and the first set of threads in about 2 hours. After that, every full recap is written with the whole season in view, so fill order matters little. Within Pass 2, going backwards means the best transcripts and the DM intros come first, which sets the quality bar before the YouTube tier.

---

## Epics

| # | Epic | Outcome | Definition of Done | Est. |
|---|---|---|---|---|
| **E0** ✅ 2026-11-06 | Tooling & rules | Cleaner handles YouTube VTTs; schema, ledger and lint exist; playbook updated | Cleaned YouTube file has timestamped multi-line output; lint passes on the 6 S3 recaps after their frontmatter is added; GMT→E37–43 map verified | 1 sitting, ~1–2 h |
| **E1** ✅ 2026-11-06 | Season 2 spine | `season2_spine.md`: one line per episode, arc boundaries, seeded `names.md`/`threads.md` | DM approves arc boundaries; every E2–E43 opening has a cited line | 1 sitting, ~2 h |
| **E2** ✅ 2026-11-06 | Arc 1, The Monolith (s02e01–s02e05) | Five recaps plus arc recap | See `plans/e2_subplan.md` Retro | 1 sitting |
| **E3…E8** | One arc per epic: 7 arcs, set in E1 (see `BarquentineWiki/season2_spine.md`) | Full recaps for that arc's episodes, plus a 3-paragraph arc recap | All episodes pass the per-episode DoD (below); arc recap written; DM line-edits done; committed | 1 sitting each, ~4–6 h |
| **Ez** | Retire old S2 files | The old project's S2E34–36 content fully replaced | No pipeline-format frontmatter left in `sessions/` | folded into the E34–36 arc |

### Per-episode Definition of Done (applies inside every arc epic)
1. Every quote and named event is found in the raw VTT with the `awk` timestamp grep.
2. The frontmatter validates (`lint_recaps.R` exits 0).
3. Every `threads_*` id exists in `threads.md`, and that entry cites this episode.
4. No later-episode reveals appear in the prose.
5. Prose follows the playbook: ≤4 paragraphs, 1–2 verbatim quotes, a title actually spoken at the table, closing tagline.

---

## Subplan template (written in plan mode at the start of each epic)

```
# <Epic id>: <name> — subplan
## Goal              one sentence
## Inputs            files, VTTs, doc tabs
## Stories           numbered; each = one bounded deliverable
##   per story:      tasks · skill calls · success criteria · check (command or review)
## Skill calls       which, and at which story
## Risks             what could make the DoD fail
## Exit check        the DoD commands, run and pasted
## Retro             (filled at close) what to change in the next subplan
```

### Skills to use

| Skill | Where |
|---|---|
| `tdd` | E0: `vtt_clean.R` YouTube mode, `lint_recaps.R` |
| `grill-me` | End of E1: stress-test the arc boundaries and thread list with the DM |
| `code-review` | E0: before committing the tooling |
| `handoff` | End of every sitting, so the next fresh session resumes cleanly |
| `session-close` | End of every sitting: update the stack rank, LESSONS and memory |

---

## Artifacts (all in `~/R-projects/barquentine_wiki/`)

| File | Purpose |
|---|---|
| `plans/s2_backfill_roadmap.md` | This roadmap, with epic status ticked off |
| `plans/<epic>_subplan.md` | One per epic |
| `tools/vtt_clean.R` | Add a no-speaker mode that writes `[hh:mm:ss] text` blocks of about 60 seconds. Today it merges everything into one line. |
| `tools/lint_recaps.R` | New. Checks frontmatter slugs against `names.md` and thread ids against `threads.md`. |
| `BarquentineWiki/season2_spine.md` | Episode lines plus the arc recaps |
| `BarquentineWiki/threads.md` | `T-###` ledger: status, each episode it touches with a cite, and its payoff |
| `BarquentineWiki/names.md` | Canonical name, slug, transcript misspellings, first appearance |
| `BarquentineWiki/sessions/s02eYY.md` | Recaps (E20 gets a stub saying the source is missing) |
| `recap_playbook.md`, `CLAUDE.md` | Add the schema, YouTube-tier rules, GMT map, S2 DM-intro mapping, spoiler rule |

### Frontmatter schema (draft; E0 finalizes it)
```yaml
episode: s02e40
title: "This Negotiation Is Over"
recorded: 2026-04-07
source: GMT20260407-012918_Recording.transcript.vtt
source_tier: zoom            # zoom | youtube
recap_prose: dm_intro s2e41  # or: generated
arc: flotilla
npcs: [geronimo, alistair, victoria, silent_jim]
places: [giff_flotilla, flotilla_brig]
items: [sphere_of_annihilation]
threads_opened: [T-021]
threads_advanced: [T-017]
threads_closed: []
callbacks: [s02e15]
```

### YouTube-tier rules (draft; E0 finalizes them)
- Attribute a quote only when the speaker is unambiguous. Otherwise narrate the moment instead of quoting it.
- Quotes are verbatim, apart from normalized case and punctuation. Never fill in `[ __ ]`.
- Fix mangled proper nouns using `names.md` and the DM prep notes, and flag any guess.
- Confirm the S2 PC roster in E1, since S1 had Pyxis.

---

## Roadmap-level verification
- Every epic closes with its exit check pasted into the subplan's Retro.
- After the first arc epic, run a callback test: grep `threads.md` for a live S3 thread (e.g. the sphere key) and confirm it lists the S2 episodes and cites that set it up.

## Open item (outside this roadmap)
`~/R-projects/barquentine_wiki/` isn't a git repo. Only `BarquentineWiki/` is, so `plans/`, `tools/` and the playbook aren't version-controlled. Decide this before E0.
