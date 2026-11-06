# CLAUDE.md — Barquentine recaps & lore

This folder is the home for Barquentine session recaps and lore. They are harvested from the Zoom `.vtt` transcripts of each session. Claude Code reads the transcripts and writes the recaps itself, with no API or pipeline. The DM (the Admiral / Jason) line-edits.

**Read `recap_playbook.md` before writing any recap or lore.** It holds the style rules, the verification rules, and the table facts (who's who, ship names, episode numbering).

## Where things live

| What | Path |
|---|---|
| Raw transcripts (NAS) | `/Volumes/share/videos/*.vtt`. Mount via Finder → Go → Connect to Server → `smb://LS220D43E.local/share` |
| Transcript cleaner | `tools/vtt_clean.R` → `vtt_to_transcript(path)` returns `Speaker: text` lines (Zoom) or `[hh:mm:ss] text` blocks (YouTube, auto-detected; `mode=` overrides) |
| Recap lint | `Rscript --vanilla tools/lint_recaps.R BarquentineWiki/sessions/<files>` exits 0 when frontmatter is valid |
| Tool tests | `Rscript --vanilla -e 'testthat::test_dir("tools/tests")'` |
| Name & thread ledgers | `BarquentineWiki/names.md` (slugs) and `BarquentineWiki/threads.md` (`T-###`) |
| Session recaps | `BarquentineWiki/sessions/sXXeYY.md` (Obsidian vault, tracked in the top-level repo on `main`) |
| Playbook | `recap_playbook.md` |
| Handoffs | `BarquentineWiki/handoffs/YYYY-MM-DD_<topic>.md`. **Every `/handoff` goes here**, not the OS temp dir. |

`BarquentineWiki/sessions/s02e34–36.md` were produced by the old wiki pipeline (`../barquentine_pipeline`, now retired) and do not follow the playbook.

## Recap workflow

1. Clean the transcript into a scratch file:
   `Rscript --vanilla -e 'source("tools/vtt_clean.R"); writeLines(vtt_to_transcript(commandArgs(TRUE)[1]), commandArgs(TRUE)[2])' <vtt> <out.txt>`
2. Read the whole cleaned transcript.
3. Hold the four-persona panel debate (see the playbook).
4. Draft `BarquentineWiki/sessions/sXXeYY.md` with these parts: the frontmatter (schema in the playbook), the prose recap, then **Lore Notes** (cite each item as `[VTT hh:mm:ss]` or `[Recap hh:mm:ss]`), then **Open Threads**.
5. Grep every quote and named event against the **raw** `.vtt` before handing the draft over. Get timestamps with:
   `awk -v p="<phrase>" 'index($0,p){print ts" | "$0} /-->/{ts=substr($1,1,8)}' <vtt>`
6. Add any new names to `names.md` and episode bullets to `threads.md`, then run the lint until it exits 0.
7. The DM line-edits. Their edits stand without pushback; redraft only the sections they touch.

## Transcript gotchas

- The NAS has duplicates: descriptive-name files (`Barquentine! S2E34 …`) and raw Zoom copies (`GMT2026…_Recording`) of the same session.
- S1 and S2E1–S2E33 transcripts are YouTube auto-captions with **no speaker labels**. S2E34–S2E43 exist both as YouTube copies and as Zoom GMT files; the **Zoom copy wins**.
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

## Season 2 sources

**GMT → episode map** (verified 2026-11-06: every GMT file shares 1,500–2,000 six-word phrases with exactly one titled YouTube copy, and at most 11 with any other).

| GMT file date | Episode | DM intro read at the top |
|---|---|---|
| 20251223 | S2E34 | s2e34 intro [VTT 00:00:16] |
| 20260113 | S2E35 | s2e35 intro [VTT 00:00:07] |
| 20260127 | S2E36 | S2e36 intro [VTT 00:00:07] |
| 20260210 | S2E37 | S2e37 [VTT 00:00:15] |
| 20260310 | S2E38 | s2e38 intro [VTT 00:00:10] |
| 20260324 | S2E39 | s2e39 intro! [VTT 00:00:13] |
| 20260407 | S2E40 | s2e40 intro! [VTT 00:00:06] |
| 20260414 | S2E41 | none. The Captain's player recaps instead [VTT 00:00:00]; the s2e41 tab was never read |
| 20260505 | S2E42 | s2e42 intro! [VTT 00:00:13] |
| 20260519 | S2E43 | S2e43 introduction [VTT 00:00:09] |

**DM intro doc:** "Barquentine Episode notes" (`1m5xXbEsPBFdTZAUoUAgj6a14I7aF8LcszCmX-r1mBbs`). Each `s2eN intro` tab recaps **S2E(N−1)**, so the tabs s2e33–S2e43 give DM prose for S2E32–S2E42. The S2e43 tab recaps the whole Flotilla arc as well as S2E42.

The same doc holds DM prep notes (tabs S2e14–S2E17, S2E25, s2e26, s2e32, "Tab 7"). They are plans, not canon, and may not be published: use them only to check spellings.

**Per-episode docs, S2E1–S2E12** (found 2026-11-06 with the Drive search `title contains 'barquentine'`). There is one Google Doc per episode, titled "Barquentine S2E2", "Barquentine S2e4" and so on. Each one opens with the DM's intro for that episode, and the intro recaps the **prior** episode, the same pattern as the tabs:

| Doc | Opens with | Gives DM prose for |
|---|---|---|
| Barquentine S2 E1 (`1XHoo2RtNrgeTFEywBArsjPrIh4il5c09pIFYjSOajXE`) | season-opening narration ("What makes a ship?") | — |
| Barquentine S2E2 (`1W-nLAiQ8s4z06XljxtihgeTjgU_ZhTa3XTosxQZ5dpw`) | intro | S2E1 |
| Barquentine S2E3 (`1YUZNnm7mB1rcq1Ev4hummmho5Or90ukh2TKD7-HX2Uw`) | **prep notes, no intro**. The table recapped E2 itself. | — |
| Barquentine S2e4 (`1-WeGLYpAcdVdUBur-rLExso6wxmjiDGp_9G81xZ_0L4`) | intro | S2E3 |
| Barquentine S2E5 (`1moq4HBvPGz2lpCIzHrDXqrfhf29u1E4sekrWvB05byA`) | intro | S2E4 |
| Barquentine! S2E6 (`1S-U3dwrTPOYtcgtEWn9ijcnsENNPw2mITapxhc-ukpM`) | intro | S2E5 |
| Barquentine S2e7 (`1Sk_qjL0rTNdk98ARjykGkS6JU9oE_W7zVix0AbFSvEI`) | intro | S2E6 |
| Barquentine S2E8 (`1ZOlNL8vmpCsbzmydC38OHuyP65S-ALMQ_N7fqDZYiSM`) | intro | S2E7 |
| Barquentine S2E9 (`1dsRZbed-KNAuV9YTUHlihEH7doJLIqUXugi-_4Qetmw`) | intro | S2E8 |
| Barquentine S2 e10 (`1r8d6_OL4VOcfPi3DZciPZ4zCsaJZIt1gMCUVuKOF3_w`) | intro | S2E9 |
| Barquentine s2 e11 (`1_xR99fVqE8Y_2VA1pikL1KZYc1MR6tGab9z8CuqfA10`) | Halloween-special narration | — |
| Barquentine S2E12 (`1lczA6DODsEWm9O7qm2UTfABaqpBo_LqFQ2mDZHHDHdQ`) | intro | S2E10 |

- Use the intro prose the way the tabs are used: copy it verbatim into the recap, drop the "Previously on" cue line, and set `recap_prose: dm_intro s2eN`.
- **Anything after the intro** (encounter tables, plans) counts as prep notes, so use it for spelling only.
- **The DM outranks the doc.** If the intro and the DM disagree, the DM's version stands. Check the intro against what was read aloud in the VTT.
- E2 and E11–E31 have no DM intro prose, so their recaps are generated.
- The Drive also holds S1 episode docs (s1E1–s1E26) and other Barquentine docs. Those aren't S2 sources.
