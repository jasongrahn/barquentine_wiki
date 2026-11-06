# CLAUDE.md — Barquentine recaps & lore

This folder is the home for Barquentine session recaps and lore. They are harvested from the Zoom `.vtt` transcripts of each session. Claude Code reads the transcripts and writes the recaps itself, with no API or pipeline. The DM (the Admiral / Jason) line-edits.

**Read `recap_playbook.md` before writing any recap or lore.** It holds the style rules, the verification rules, and the table facts (who's who, ship names, episode numbering).

## Where things live

| What | Path |
|---|---|
| Raw transcripts (NAS) | `/Volumes/share/videos/*.vtt`. Mount via Finder → Go → Connect to Server → `smb://LS220D43E.local/share` |
| Transcript cleaner | `tools/vtt_clean.R` → `vtt_to_transcript(path)` returns `Speaker: text` lines |
| Session recaps | `BarquentineWiki/sessions/sXXeYY.md` (Obsidian vault, git repo on `master`) |
| Playbook | `recap_playbook.md` |
| Handoffs | `BarquentineWiki/handoffs/YYYY-MM-DD_<topic>.md`. **Every `/handoff` goes here**, not the OS temp dir. |

`BarquentineWiki/sessions/s02e34–36.md` were produced by the old wiki pipeline (`../barquentine_pipeline`, now retired) and do not follow the playbook.

## Recap workflow

1. Clean the transcript into a scratch file:
   `Rscript --vanilla -e 'source("tools/vtt_clean.R"); writeLines(vtt_to_transcript(commandArgs(TRUE)[1]), commandArgs(TRUE)[2])' <vtt> <out.txt>`
2. Read the whole cleaned transcript.
3. Hold the four-persona panel debate (see the playbook).
4. Draft `BarquentineWiki/sessions/sXXeYY.md` with these parts: the prose recap, then **Lore Notes** (cite each item as `[VTT hh:mm:ss]` or `[Recap hh:mm:ss]`), then **Open Threads**.
5. Grep every quote and named event against the **raw** `.vtt` before handing the draft over. Get timestamps with:
   `awk -v p="<phrase>" 'index($0,p){print ts" | "$0} /-->/{ts=substr($1,1,8)}' <vtt>`
6. The DM line-edits. Their edits stand without pushback; redraft only the sections they touch.

## Transcript gotchas

- The NAS has duplicates: descriptive-name files (`Barquentine! S2E34 …`) and raw Zoom copies (`GMT2026…_Recording`) of the same session.
- S1 transcripts are plain auto-captions with **no speaker labels**.
- Proper nouns are mangled by transcription: "Barquet"/"barcodeine" = Barquentine, "GIF"/"gift" = Giff, "Key Ren"/"Kyron" = Ki-Rin.
- Each session opens with the DM's "Previously on Barquentine" segment. It recaps the **prior** episode and is the target voice for recaps.

## DM's written intros (source of truth)

The Google Doc **"Barquentine S3 notes"** (`1-3qYQxAMc7TZ2PZElrNrwvfzFP5m40Zk5SW2JR5-zuE`) holds the DM's "Previously on" intros, one tab per intro. Each **"S3eN intro" recaps episode N−1**. When an intro exists, its prose replaces the generated recap prose in `sessions/s03eXX.md`, copied verbatim with the "Previously on Barquentine" cue line dropped. Lore Notes and Open Threads stay as generated.

| Doc heading | Becomes the recap for |
|---|---|
| See1 intro | — (season-opening narration, not a recap) |
| S3e2 intro *(added 2026-11-03 from the generated recap)* | S3E1 |
| S3e3 intro | S3E2 |
| s3e4 intro | S3E3 |
| S3e5 intro | S3E4 |
| S3e6 intro *(filled 2026-11-03 from the generated recap)* | S3E5 |
