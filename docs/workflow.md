# The Workflow

This document explains the session ritual that makes cairn work. The whole template is designed around it — if you skip the ritual, the rest of the structure produces nothing.

## The three moments

Every session has three distinct moments: **start**, **during**, and **end**. Each one has a specific job. Skipping any of them costs you the continuity benefit.

### Start

The job of the start is **fast context recovery**. You should not spend ten minutes re-explaining what you were doing two days ago.

The mechanism is the **resume point** — a single paragraph written at the end of the previous session that tells future-you (or Claude) exactly where you left off and what to do next. The format is:

```
[Topic]. Read the resume point in [file path] and [relevant master doc], then [what to do next].
```

Paste that paragraph as the first message in a new conversation. Claude reads the referenced files, confirms what it found in a 2-3 sentence summary, and starts working. Total time from cold start to working: under a minute.

If you didn't write a resume point last time (or you're starting fresh), the first session just begins with what you want to work on. After that, the ritual takes over.

There's a second job at the start, and it becomes the more important one as a project matures: **grounding**. Before Claude proposes anything, it should check whether the thing you're asking for is already decided or already done — by reading the actual work, not just the documents describing it. On a project more than a few sessions old, "let's design this" surprisingly often turns out to be "we decided this in session six and built half of it." Two reads is a cheap price for not redoing settled work.

### During

The job of the during is **structured exploration**. The work should accumulate cleanly into the files at the end, which means it has to be structured-enough as you go.

Sessions come in two modes, and they have different rhythms. Most sessions are mostly one or the other.

**Design mode** is deciding what to do. The rhythm is **one question at a time.** Don't batch. Claude asks one question, you give a gut answer, the answer gets pressure-tested by discussion, the question gets resolved (or parked as an open question). Then the next question. This is the rhythm that produces good decisions. Batched questions produce shallow ones. The same rhythm works well for chewing through a pile of feedback or bug reports, not just for open design questions.

**Build mode** is doing it. The rhythm is **plan, do one unit, verify, commit, next unit.** The trap here is a different one: it is very easy to end a build session believing more works than actually works. "It compiles," "the tests pass," and "I committed it" are not evidence that the thing works. The only evidence is looking at the real output, the real artifact, the real running thing. If Claude can't verify something, it should say so rather than let "I made the change" quietly stand in for "the change works."

Three habits matter in both modes:

1. **Flag decisions explicitly.** When a decision is made, Claude should say it out loud: "DECISION: [what was decided]." This makes the decision findable later. Decisions made implicitly disappear into chat logs.

2. **Park drift.** Conversations drift. When they do, Claude flags the drift rather than going along with it: "This is interesting, but it belongs in [other topic]. Want to note it and come back to our current topic?" Drift that gets parked turns into future work. Drift that gets followed turns into a session with no clear outcome.

3. **Nothing important stays in the chat.** If you paste in a collaborator's feedback, a tester's notes, or any other outside material, Claude should write it to a file verbatim before working with it. The conversation does not survive the session. Anything living only in the chat is already lost — you just don't know it yet.

### End

The job of the end is **handoff to future you**. Five things should exist when the session is over:

1. **Updated `Brainstorm.md`** with a dated session entry appended. Format:
   ```
   ## Session: [DATE] — [Brief topic description]
   
   ### Context
   ### Key Thinking
   ### Decisions Made
   ### Open Questions
   ### Changes to Master
   ### Resume Point
   ```
   If you run more than one session in a day, suffix them: `2026-03-14 pt-2`, `pt-3`. On an active project the date alone stops being a unique name quickly.

2. **Updated `Master.md`** if anything meaningful changed. Don't touch it if nothing did — the master should always be a clean current-state read.

3. **Session summary** — a few bullet points you can scan: what was worked on, what was decided, what's still open, which files were updated, suggested next session.

4. **Next session prompt** — the ready-to-paste paragraph for the next conversation. This is the single most leveraged deliverable. Skip everything else if you must, but produce this.

5. **(Optional) Process_Meta_Notes entry** if something about the workflow itself was notable. Most sessions don't need this. Don't force it.

You trigger the end by typing **"wrap it up"** or **"end session."** Claude should not produce these deliverables on its own — they only happen on your signal. This is intentional: it ensures the session ends when you're ready, not when Claude thinks it should.

With one exception. Claude should tell you when its context is filling up, at roughly the 70% mark, and recommend wrapping. It shouldn't wrap on its own, but it shouldn't stay quiet either. A session that runs far past that point can reach a state where the wrap-up itself no longer fits in context — at which point the session can't be closed at all, and recovering it costs a whole extra session. The decision stays yours; the warning is Claude's job.

If the project is under version control, the wrap ends by **pushing**, not just committing. Committing protects the work on this machine. Pushing is what actually protects it. It's worth a quick check for anything committed locally but never pushed — that pile grows silently.

## Why this works

The friction in long projects with AI is **context loss between sessions**. The AI cannot remember what you discussed yesterday. You can, but barely, and you definitely don't remember by next week.

The brainstorm/master pair is one solution: write down the thinking so the files become Claude's memory. The session ritual is another: structure the writing so it's actually useful as memory rather than just a transcript.

The two combine into a workflow that scales further than chat alone. The proof point: projects that have run for months across dozens of sessions, where every session can pick up cleanly from the previous one because the resume point and the files are doing the work that a single conversation's context would normally do.

## When the workflow breaks down

A few failure modes worth knowing:

- **Wrapping without "wrap it up."** Closing the conversation without producing the deliverables. The session is then lost. Set yourself a habit: every session ends with the phrase before you close the window.

- **Master drift.** The Brainstorm.md updates every session but the Master.md falls behind. After 4-5 sessions of accumulated decisions, the master rewrite becomes a chore. Fix: update the master in the same session as the decision, not as a batch later.

- **Open question accumulation.** Open questions are easier to add than to close. Periodically review the open-question list and decide which are still load-bearing versus quietly stale. Stale OQs that nobody will ever answer should be deleted (with a note in the brainstorm explaining why).

- **Topic drift not parked.** A session about marketing drifts into a session about pricing. By the time it ends, neither topic has a clean entry. Fix: when you notice the drift, stop, and decide which topic this session belongs to. If both, split it.

- **Brainstorm bloat.** A `Brainstorm.md` gets so long it's painful to read. Fix: archive older sessions to a separate file (`Brainstorm_Archive_Q1.md`) and keep the current quarter in the active file. The master doc should still be the source of truth for current state.

- **The session that ran too long to close.** You keep going past the point where Claude flagged context. Eventually the wrap-up won't fit and the session can't be closed. The work isn't gone, but recovering it costs a full session. Fix: when Claude says context is tight, wrap. There's always another session.

- **"Done" that was never verified.** A session ends with a list of things reported as finished. Half of them were made, not confirmed. This compounds quietly — the next session builds on the assumption, and the failure surfaces weeks later somewhere unrelated. Fix: in build sessions, treat "how did we confirm this?" as part of the wrap. Anything that couldn't be verified gets said out loud and carried forward as unverified, not quietly listed as done.

- **Status that's only ever checked against itself.** A tracking document gets updated from another tracking document, which was updated from a summary of a session. After a few rounds, it confidently describes things that never happened. Fix: reconcile status against the actual work — the files, the artifacts, the running thing — not against the previous status document. Documents inherit each other's mistakes.

- **Re-deciding settled things.** Nobody checked whether the topic was already resolved, so a session spends an hour arriving at a decision that's already sitting in `Master.md`. Fix: this is what grounding at the start is for. It's the cheapest habit in the workflow and it pays for itself the first time it fires.
