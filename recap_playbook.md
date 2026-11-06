# Barquentine Recap & Lore Playbook

Rules for writing session recaps and lore notes from `.vtt` transcripts (Zoom and YouTube). Claude Code writes these directly; the DM (the Admiral) line-edits.

## Verification first

Fabrication is the failure mode. Check every specific claim against the **raw VTT lines**, not against memory of a single read.
- Re-grep every quote and named event before finalizing. A single pass tends to merge adjacent beats.
- Give chronology extra scrutiny.
- If a detail can't be verified, cut it. Don't theorize it into something plausible.

## Workflow

1. Clean the transcript (`tools/vtt_clean.R`) and read all of it.
2. Make two passes: grep for keywords to get timestamps, then pull the context around them.
3. **Panel debate before any prose.** Four personas work out the shape of the recap: Cartoon Recapper, Serialized Drama Writer, Tabletop Gaming Narrator, Pulp Adventure Writer. This is the higher-value step, not a formality.
4. Draft.
5. The DM line-edits. Accept corrections without pushback, and redraft only the affected section.

## Recap style

- **Four paragraphs max** for a single session. **Exactly three** for an arc-level recap.
- Punchy prose influenced by anime and Batman, with varied sentence length.
- Dialogue goes in *italics*, **verbatim from the transcript**. Never paraphrase or invent it.
- **Quote sparingly: 1–2 per recap.** Anime-narrator overviews tell the story in the narrator's voice and save quotes for the line that lands hardest. Fold everything else into narration.
- No dice numbers, unless one roll is the narratively significant moment of the session.
- No table talk, meta-commentary, or mechanical exposition: no skill names, DCs, or spell names.
- Close on stacked rhetorical questions that resolve into the fixed tagline: **"Find out this time, on Barquentine!"**
- The title is a short, memorable phrase that was **actually spoken at the table**, never an invented label. Pop-culture references are welcome.
  - **S2 exception:** the episode's YouTube filename title stands, even when the captions don't contain it (see `season2_spine.md`). Only episodes with no filename title (s02e02, s02e04, s02e20, s02e41) need a spoken phrase.

## Lore notes

- Use citation-level rigor. Tag each claim with its source: **[VTT hh:mm:ss]** for in-session lines, **[Recap hh:mm:ss]** for the DM's "Previously on" segment, which recaps the prior episode.
- Note anomalies instead of smoothing them over: transcription variants, player riffs, D&D Beyond stand-in items.

## Table facts

- **The Admiral** is the DM (Jason). Narration, rulings, and every NPC voice come through this label.
- **Lumi** is played by Chase.
- **Room** is played by John.
- **The Captain** is Basil, played by David.
- **"Mira" speaker label:** a player voicing the NPC Mira. Their lines are Mira's, except where the Admiral steps in to add color.
- The ship's names, in order: **Ki-Rin → The Ki-Rin's Blessed Vengeance → The Manticore**. "Quinoa" is Lumi's player riffing.
- **Elder Abarat** is the canon spelling (transcripts render it Abarath, Abarrett, Abberet, Aberatt).
- **S2 PC roster:** Basil, Room, Lumi and Cyan. Cyan is called **Blue** until his color shifts in s02e12, and he leaves with Vermilion in s02e14. Pyxis, from S1, is gone before s02e01. Lumi is short for **Luminariel** (s02e07).
- **S2 spellings set by the DM:** Phathalos, Island of Bral, Tiny's Tipsy by the Sea, Captain Welsh, Attornash, King Buhrghur, Davitt. `BarquentineWiki/names.md` holds every name and its caption variants.
- Episode IDs are `sXXeYY`. 2026-10-20 = **S3E5**.

## Frontmatter

Every recap opens with a YAML block above its H1. `tools/lint_recaps.R` checks it; a recap isn't done until the lint exits 0.

```yaml
---
episode: s03e06                     # matches the filename
title: "It Really Ties It Together" # identical to the H1
recorded: 2026-11-03                # local date the session was played
source: GMT20261104-021831_Recording.transcript.vtt
source_tier: zoom                   # zoom | youtube
recap_prose: generated              # or: dm_intro s3e7 (the intro tab whose prose is used)
arc: ~                              # arc slug; ~ until E1 names the arcs
npcs: [mira, victoria]              # slugs from names.md, type npc
places: [mira_lair]                 # slugs from names.md, type place
items: [victorias_chest]            # slugs from names.md, type item
threads_opened: []                  # T-### ids from threads.md
threads_advanced: [T-007]
threads_closed: []
callbacks: [s03e02]                 # earlier episodes this one pays off or echoes
---
```

- The PCs (`basil`, `room`, `lumi`) are in every episode, so they stay out of `npcs`. The ship goes in as `the_manticore`.
- Every slug must be in `names.md`, with the type matching its key. Add a new name there first.
- Every thread id must be in `threads.md`, and that thread must list the episode as a `- sXXeYY — …` bullet. Add the bullet first.
- `threads_opened` = the thread's first episode, `threads_closed` = the last episode of a thread marked `status: closed`, `threads_advanced` = every other episode on it.

## Spoiler rule

- **Prose is written as of its own episode.** A recap never reveals what later episodes show, even when we know it.
- Payoffs go in `threads.md`, and in Open Threads only as an italic *(SxEy pays off.)* pointer.
- The repo is public and players read it. Never put DM prep notes, future-arc ideas or `brewed_lore/` material in any tracked file. The DM's prep notes may be used to check a **spelling**, nothing else.

## YouTube-tier transcripts (S2E1–S2E33)

These are auto-captions: no speaker labels, and `[ __ ]` where a word was censored. The cleaner turns them into `[hh:mm:ss] text` blocks of about a minute, and `>>` marks a change of speaker.

- **Attribute a quote only when the speaker is unambiguous** from context (the DM narrating, a character addressed by name, a voice only one player does). Otherwise narrate the moment instead of quoting it.
- Quotes stay verbatim, apart from normalized case and punctuation. **Never fill in `[ __ ]`.**
- Fix mangled proper nouns with `names.md` (the transcript-variants column). Flag any guess in Lore Notes as an *Anomaly*.
- Each episode opens with the DM's "Previously on", which recaps the prior episode. Cite it as **[Recap hh:mm:ss]**.
- The S2 PC roster is in **Table facts**. Blue and Cyan are one character; use the slug `cyan`.

## Worldbuilding (separate mode)

Collaborative lore design. Claude acts as a structured panel of roles suited to the problem (e.g. Geologist / Mythologist / Warden / Dramatist); the DM sets creative direction and has final say.
