#!/usr/bin/env bash
#
# cairn — wrap reminder hook
#
# WHAT THIS DOES
#   Nudges Claude to offer a wrap-up at the two moments a session is most
#   likely to be lost:
#     1. After the conversation compacts (context is full — a session that
#        runs much further can become impossible to wrap at all).
#     2. Once a session passes a turn threshold (the ordinary case: you're
#        deep in the work and about to close the window without wrapping).
#
#   It fires at most once per session per trigger. It talks to Claude, not
#   to you — Claude decides how to raise it, and you decide whether to wrap.
#
# WHAT THIS DOES NOT DO
#   No network access. No writes outside a temp directory. Never blocks
#   Claude, never blocks a tool call, never ends your session. If anything
#   in here fails, it exits cleanly and Claude carries on unaffected.
#
# NOT ACTIVE BY DEFAULT
#   Nothing runs this unless you opt in. The cairn setup flow offers to
#   install it, which writes .claude/settings.local.json — a file that is
#   gitignored and stays on your machine. It is never committed, so cloning
#   cairn never executes anything.
#
# TUNING
#   CAIRN_WRAP_AFTER_TURNS  turns before the first nudge (default 25)
#
set -uo pipefail

THRESHOLD="${CAIRN_WRAP_AFTER_TURNS:-25}"

payload="$(cat 2>/dev/null || true)"
[ -n "$payload" ] || exit 0

# Pull a top-level string field out of the hook payload without requiring jq,
# which is not installed everywhere.
field() {
  printf '%s' "$payload" \
    | tr -d '\n' \
    | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" \
    | head -1
}

event="$(field hook_event_name)"
session="$(field session_id)"
source_kind="$(field source)"

# additionalContext is read by Claude, not shown to you directly.
emit() {
  printf '{"additionalContext":"%s"}\n' "$1"
  exit 0
}

state_dir="${TMPDIR:-/tmp}"
[ -n "$session" ] || session="nosession"

case "$event" in
  SessionStart)
    [ "$source_kind" = "compact" ] || exit 0
    marker="${state_dir}/cairn-wrap-compact-${session}"
    [ -e "$marker" ] && exit 0
    : > "$marker" 2>/dev/null || true
    emit "This conversation has just been compacted, which means the session context is full. Per the cairn workflow, tell the user plainly that context is now tight and recommend wrapping up soon: a session that runs much further past this point can reach a state where the wrap-up itself no longer fits, at which point the session cannot be closed cleanly at all and recovering it costs a whole extra session. Do not wrap unilaterally. Offer, give a one-line reason, and let the user decide."
    ;;

  Stop)
    counter="${state_dir}/cairn-wrap-turns-${session}"
    count=0
    [ -f "$counter" ] && count="$(cat "$counter" 2>/dev/null || printf 0)"
    case "$count" in (*[!0-9]*|"") count=0 ;; esac
    count=$((count + 1))
    printf '%s' "$count" > "$counter" 2>/dev/null || true

    # Fire exactly on the threshold turn so the nudge lands once, not every
    # turn afterwards.
    [ "$count" -eq "$THRESHOLD" ] || exit 0
    emit "This cairn session has now run ${THRESHOLD} turns without wrapping. At a natural pause in the current work, remind the user that nothing from this session is saved until they say 'wrap it up', and offer to wrap now. Keep it to one or two sentences and do not derail whatever is in progress. Do not wrap unilaterally, and do not raise this again unless the user asks."
    ;;
esac

exit 0
