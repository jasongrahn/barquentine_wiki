---
name: vtt-quote
description: Find, quote and cite lines from a Barquentine session VTT accurately, and verify a recap's quotes. Use when writing or checking any quote, timestamp, attribution or summary of a deal, ruling or roll in a Barquentine recap, or when the user asks "what exactly did X say", "double-check this quote" or "who offered/said that".
---

# vtt-quote

Every quote and every summary of what someone said must match the **raw** `.vtt`, the right speaker, and the right order. In D&D the exact terms of a bargain or ruling matter.

## Tools

| Need | Command |
|---|---|
| Find a phrase (case-insensitive, spans two caption lines) | `tools/vgrep.sh "<raw.vtt>" "<phrase>" ["<phrase>" …]` |
| Read the whole exchange around a moment | `awk '/-->/{ts=substr($1,1,8); next} NF && !/^WEBVTT/ && ts>="HH:MM:SS" && ts<="HH:MM:SS" {print ts" \| "$0}' "<raw.vtt>" \| awk '!seen[$0]++'` |
| Check every quote and citation in a recap | `Rscript --vanilla tools/cite_check.R <recap.md> "<raw.vtt>"` |

- Raw VTTs: `/Volumes/share/videos/Barquentine! S2E<NN> <title>.transcript.vtt`. Glob with `ls /Volumes/share/videos/"Barquentine! S2E25 "*.transcript.vtt`. If `/Volumes/share` is missing, the NAS is unmounted: ask the user to mount it.
- Cleaned transcripts (`cache/transcripts/`) use 10-second blocks, so their stamps run up to ~10 s ahead of the raw cue. **Cite raw cue times**, never block stamps.
- `rtk` compresses grep/cat output; the commands above are unaffected, but use `/usr/bin/grep` or `rtk proxy cat` for other raw reads.

## Quoting a moment

1. `vgrep` the phrase to get the raw cue time.
2. Read the exchange with the awk window, starting about 60 s before the line. Identify who speaks each line from context: the DM's narration ("he says", "you hear back"), the character addressed by name, whose roll was called.
3. **Deals, bargains, rulings, rolls, offers:** quote the exchange in order (who asked, who offered, what was accepted), each line with its own timestamp. Never compress a bargain into one verb ("Basil gives his name") until the exchange shows that is what happened.
4. Quote verbatim, apart from case and punctuation. Never fill in `[ __ ]`. A DM-ruled spelling (`names.md`) may replace a caption's mangled name inside a quote; `cite_check` will report it as `near`, which is fine.
5. Cite `[VTT hh:mm:ss]`, or a range `[VTT a–b]` when a quote or summary spans cues. Cite a line from another episode as `[VTT sXXeYY hh:mm:ss]`. `[Recap …]` is only for the DM's "Previously on" segment, not a player recap.

## Checking a recap

1. Run `cite_check.R`. Fix every `off` (move the citation to the `found` time) and every `missing` (find the real wording or cut the quote).
2. Judge each `near`: a DM-normalized name passes; anything else gets the verbatim caption.
3. `cite_check` can't see paraphrases or attributions. For each named event and each "X says/offers/asks", read the exchange with the awk window and confirm speaker and order.
4. Re-run `cite_check` until it exits 0.
