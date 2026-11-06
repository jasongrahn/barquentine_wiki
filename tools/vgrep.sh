#!/bin/bash
# vgrep.sh <vtt> <phrase>... : find each phrase in the raw VTT, allowing it to span two caption lines.
v="$1"; shift
for p in "$@"; do
  echo "## $p"
  awk -v p="$p" '
    /-->/ {ts=substr($1,1,8); next}
    /^[0-9]+$/ || /^WEBVTT/ || NF==0 {next}
    { cur=$0; win=prev " " cur
      if (index(tolower(cur),tolower(p))) print ts" | "cur
      else if (prev!="" && index(tolower(win),tolower(p))) print pts" | "prev" / "cur
      prev=cur; pts=ts }' "$v" | head -3
done
