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

3. **Nothing important stays in the chat.** If you paste in a collaborator's feedback, a tester's notes, or any other outside material, Claude should write it to a file verbatim before working with it. Anything living only in the chat is unprotected: it will not be in the files the next session reads. For anything long, hand Claude the file rather than pasting it — pasted text gets silently truncated at a size you will not notice, and a file does not.

There is a fourth habit that becomes load-bearing as models get more capable, and it is covered in its own section below: **the user's outward words are the user's.** Claude prescribes edits to them; it does not apply them.

A note on decisions: "flag it" means write it to the file in the same turn. Not at wrap-up. The most common way work gets dropped on a long project is a decision that was said out loud, agreed, and never written anywhere until the session ended without a wrap.

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

5. **(Optional) Process_Meta_Notes entry** if something about the workflow itself was notable. Most sessions don't need this. Don't force it. When a lesson shows up for the second time, promote it into `CLAUDE.md` as a dated rule with the incident that taught it. Meta notes are read when you go looking; `CLAUDE.md` is read every session.

You trigger the end by typing **"wrap it up"** or **"end session."** Claude should not produce these deliverables on its own — they only happen on your signal. This is intentional: it ensures the session ends when you're ready, not when Claude thinks it should.

With one exception. Claude should tell you when its context is filling up, at roughly the 70% mark, and recommend wrapping. It shouldn't wrap on its own, but it shouldn't stay quiet either. A session that runs far past that point can reach a state where the wrap-up itself no longer fits in context — at which point the session can't be closed at all, and recovering it costs a whole extra session. The decision stays yours; the warning is Claude's job.

If the project is under version control, the wrap ends by **pushing**, not just committing. Committing protects the work on this machine. Pushing is what actually protects it. It's worth a quick check for anything committed locally but never pushed — that pile grows silently.

### The wrap reminder (optional)

Everything above depends on a habit: you typing "wrap it up" before you close the window. That habit is the entire workflow, and it is also the single easiest thing to forget. Documentation can teach a habit but it cannot install one.

Cairn ships a small script, `.cairn/hooks/wrap-reminder.sh`, that nudges Claude to offer a wrap-up at the two moments a session is most likely to be lost — when the conversation compacts, and once a session has run past a turn threshold. It talks to Claude rather than to you; Claude decides how to raise it and you decide whether to wrap. It never blocks anything and never wraps on its own.

**It is off unless you turn it on.** The setup flow offers to install it, which writes `.claude/settings.local.json` — gitignored, so it stays on your machine. You can also ask Claude to add or remove it at any point, or change the threshold with `CAIRN_WRAP_AFTER_TURNS` (default 25).

The reason it isn't pre-wired deserves saying plainly, because it applies well beyond cairn. Hooks are shell commands Claude Code runs automatically. A repository that ships hooks already switched on executes code on everyone who clones it, before they have looked at anything — which is why a committed `.claude/settings.json` full of hooks should be read with the same suspicion you'd give a strange install script. Cairn ships the script inert and asks first. If you ever clone a template that doesn't, read its hooks before you run it.

## Why this works

The friction in long projects with AI is **context loss between sessions**. The AI cannot remember what you discussed yesterday. You can, but barely, and you definitely don't remember by next week.

The brainstorm/master pair is one solution: write down the thinking so the files become Claude's memory. The session ritual is another: structure the writing so it's actually useful as memory rather than just a transcript.

The two combine into a workflow that scales further than chat alone. The proof point: projects that have run for months across dozens of sessions, where every session can pick up cleanly from the previous one because the resume point and the files are doing the work that a single conversation's context would normally do.

## When the workflow breaks down

A few failure modes worth knowing:

- **Wrapping without "wrap it up."** Closing the conversation without producing the deliverables. The session is not distilled, and the next one starts blind. It is not gone: Claude Code keeps full session transcripts on disk under `~/.claude/projects/`, and Claude can search them if you say "we discussed this in a past session." Recovery costs most of a session, though, and nobody remembers the transcripts exist until something is missing. Set yourself a habit: every session ends with the phrase before you close the window.

- **Master drift.** The Brainstorm.md updates every session but the Master.md falls behind. After 4-5 sessions of accumulated decisions, the master rewrite becomes a chore. Fix: update the master in the same session as the decision, not as a batch later.

- **Open question accumulation.** Open questions are easier to add than to close. Periodically review the open-question list and decide which are still load-bearing versus quietly stale. Stale OQs that nobody will ever answer should be deleted (with a note in the brainstorm explaining why).

- **Topic drift not parked.** A session about marketing drifts into a session about pricing. By the time it ends, neither topic has a clean entry. Fix: when you notice the drift, stop, and decide which topic this session belongs to. If both, split it.

- **Brainstorm bloat.** A `Brainstorm.md` gets so long it's painful to read. Fix: archive older sessions to a separate file (`Brainstorm_Archive_Q1.md`) and keep the current quarter in the active file. The master doc should still be the source of truth for current state.

- **The session that ran too long to close.** You keep going past the point where Claude flagged context. Eventually the wrap-up won't fit and the session can't be closed. The work isn't gone, but recovering it costs a full session. Fix: when Claude says context is tight, wrap. There's always another session.

- **"Done" that was never verified.** A session ends with a list of things reported as finished. Half of them were made, not confirmed. This compounds quietly — the next session builds on the assumption, and the failure surfaces weeks later somewhere unrelated. Fix: in build sessions, treat "how did we confirm this?" as part of the wrap. Anything that couldn't be verified gets said out loud and carried forward as unverified, not quietly listed as done.

- **Status that's only ever checked against itself.** A tracking document gets updated from another tracking document, which was updated from a summary of a session. After a few rounds, it confidently describes things that never happened. Fix: reconcile status against the actual work — the files, the artifacts, the running thing — not against the previous status document. Documents inherit each other's mistakes.

- **Re-deciding settled things.** Nobody checked whether the topic was already resolved, so a session spends an hour arriving at a decision that's already sitting in `Master.md`. Fix: this is what grounding at the start is for. It's the cheapest habit in the workflow and it pays for itself the first time it fires.

- **The re-raised flag.** Claude suggested something, you said no, and three turns later it suggests it again with slightly different wording. Each re-raise costs you a decision you already made. Fix: the rule in `CLAUDE.md` is flag once, then respect the decision. A genuinely new argument is fine; the same flag again is not. If it keeps happening, say "you've flagged that, I decided" and it should stop.

- **The confident wrong assertion.** Claude states something checkable as fact, you push back, and it turns out you were right. On long projects this has happened often enough to be a pattern rather than an incident. Fix: the model should concede fast, re-derive, and check what else the wrong premise touched. Your side of the fix is to push back whenever something reads as more certain than the evidence you've seen supports.

- **Claude edited your document.** You asked for suggestions on something that goes out under your name and got back a rewritten file. Now it's in Claude's voice, you can't defend every sentence cold, and readers can tell. Fix: the "whose words" split below, written into `CLAUDE.md` so it holds across sessions.

## Working with more capable models

Cairn was first built around models that needed to be pushed to do enough. The models since then need something different. They will happily do more than you asked, apply an edit you wanted to review, re-open a question you closed, and state a checkable claim with confidence. None of this is malice and most of it is useful. It just means the discipline that matters has shifted from *making Claude do the work* to *keeping Claude inside the lines while it does*. The rules that emerged from running several projects on the newer models are in the template `CLAUDE.md`, and they are the ones this document keeps pointing at:

- **Ground before proposing.** Read the actual work before designing on top of it.
- **Flag once, then respect the decision.**
- **Concede fast on corrections, then re-derive.**
- **Prescribe, never apply, on anything the user owns.**
- **Verify, then declare.** Including proving a check can fail before trusting a clean result.
- **Write decisions down the moment they are made.**

### Whose words these are

The single biggest change in how the later projects ran: a hard split between work Claude owns and work the user owns.

Claude-owned work (build files, scaffolding, figures, internal notes) gets edited directly once the plan is agreed. User-owned work (anything that leaves the project under the user's name, and anything the user has said is theirs) gets *prescribed* edits: targeted from→to changes the user applies, skeletons and intent notes rather than finished prose, sample phrasing explicitly marked as Claude's to rewrite. Once an outward artifact's content is locked, no new generated text goes in.

The reason this became a rule is practical, not principled. A memo submitted for evaluation, a message to a tenant, an email to a cofounder: the reader judges the person, and the person has to be able to defend every sentence without notes. Prose that is 90% Claude reads as such, and the 10% the user can't explain is where it falls apart. Projects that adopted this split produced better outward work and had less anxiety about it.

### Which model, for which session

One observation held across many sessions of a build-heavy project, and it maps directly onto the two session modes:

- **Design sessions** (deciding, pressure-testing, writing prompts or specs, editorial judgment) went to the most capable model available.
- **Build sessions** (mechanical implementation, running verification, porting something that already has a spec) went to a faster, cheaper one.
- **Switching models mid-session was expensive**, because the new model re-reads everything and the cache is lost. The rhythm that worked was one session, one mode, one model, with the switch at the wrap. The exception that also worked: a small build done on the more capable model because every file it needed was already in context.

Treat this as a starting point rather than a law. It is one project's experience, and model pricing and capability change often. The cheap habit that makes it possible to learn your own answer is the `Model:` line under each session header in `Brainstorm.md`, so that when you look back at a decision or a build you can see which model made it.
