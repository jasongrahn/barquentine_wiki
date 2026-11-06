# Barquentine Recap & Lore Playbook

Rules for writing session recaps and lore notes from Zoom `.vtt` transcripts. Claude Code writes these directly; the DM (the Admiral) line-edits.

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
- Episode IDs are `sXXeYY`. 2026-10-20 = **S3E5**.

## Worldbuilding (separate mode)

Collaborative lore design. Claude acts as a structured panel of roles suited to the problem (e.g. Geologist / Mythologist / Warden / Dramatist); the DM sets creative direction and has final say.
