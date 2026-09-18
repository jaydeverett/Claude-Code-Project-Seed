# Optional Patterns

Patterns that work well for some projects but are not part of the minimal cairn template. Add them when the project actually needs them, not by default.

## Decision and question numbering

Some projects accumulate enough decisions that referencing them by name gets clumsy. ("Remember the decision about format from session 3?" — which one?) Numbering each decision and each open question creates a stable, short reference.

**Convention:** Decisions get a per-topic prefix and a number (`F1`, `F2` for "Foundation"; `P1`, `P2` for "Production"). Open questions get `OQ` after the prefix: `F-OQ1`, `P-OQ1`. The worked example at `.cairn/example/` uses this pattern.

When to adopt:
- You're past ~10 decisions and still referencing them across sessions
- You have multiple folders that reference each other's decisions
- You find yourself paraphrasing past decisions instead of pointing to them

When not to:
- Project is small or short-lived
- Decisions are mostly local to one topic
- You don't reference past decisions often enough for the numbering to pay off

## A build backlog

The Brainstorm/Master pair holds two things well: how the thinking evolved, and what you currently believe. Neither holds a third thing — **what you have committed to doing, and whether it's done yet.**

This gap is usually invisible until a project starts building. The symptom is a specific, recurring anxiety: *"I think things are getting dropped between sessions."* Usually they are. A decision written into `Master.md` is safe. But the checklist of what that decision implies — the six things to build, four of them finished — lives only in the session, and the session ends.

**Pattern:** a `BACKLOG.md` at the project root. One line per committed item, with a status. The rule that makes it work is about timing, not format:

> Every decision becomes a backlog line **the moment it's made**, in the same breath as "DECISION: ...". Not at wrap-up, not in a later cleanup pass.

Two habits keep it honest:

- **Reconcile against the work, not against other documents.** Check the backlog against the actual files, artifacts, or running thing. A status doc seeded from another status doc inherits every unverified claim in it, and the errors compound in both directions — things marked done that were never built, and things marked pending that shipped weeks ago.
- **A description is not proof.** "Committed" and "works" are different claims, and a note saying an item is handled is not evidence that it is. When reconciling, look for the item's actual user-visible result.

When to adopt:
- The project has moved from deciding into making
- You've caught yourself asking "did we ever finish that?" more than once
- Decisions routinely imply multiple pieces of work rather than being self-contained

When not to:
- The project is still purely in a thinking phase — `Master.md` covers you
- Work items are small enough that each session finishes what it starts

## Incoming feedback files

The stakeholder sync file below is outbound: what you send someone. This is the inbound counterpart, and it's the one people lose work to.

When someone gives you a batch of feedback — a collaborator's notes, a tester's list of problems, a client's reactions — and you paste it into the conversation, it exists **only** in that conversation. Deciding to handle it next session silently destroys it. This is a real and easy mistake: the work feels captured because you can see it on screen.

**Pattern:** paste it to a file first, before any discussion of it. `Feedback_2026_03_14.md`, or a running `Feedback.md`. Verbatim, uninterpreted.

Then, for anything more than a handful of items, add a **disposition** to each one before starting work: doing now, doing later, not doing, needs a decision first. Writing every item down with a disposition before touching anything is what stops items from silently vanishing in the middle of a long list.

Two things worth knowing:

- Above roughly 20 items, do an explicit "anything not covered?" pass at the end, against the original list. "I think we got everything" is wrong more often than it's right, and the pass takes minutes.
- A suggestion is not a specification. When someone proposes an exact fix or exact wording, it encodes an intent. Implement the intent — the literal version often breaks something the person suggesting it couldn't have known about.

## Stakeholder sync files

If you regularly update a cofounder, manager, client, or community on the project, a dedicated sync file is worth its weight.

**Pattern:** Create `Stakeholder_Update.md` (or `Cofounder_Update.md`, `Client_Update.md` — name it for who it's for) at the root of the project. The file is **read-only by the stakeholder, generated on demand by you**.

Workflow:
- When the user says "update the stakeholder file," Claude regenerates it from the brainstorms.
- The file contains only **work since the last update** — not cumulative history.
- The file highlights: decisions made, open questions, items needing the stakeholder's input, files modified, remaining work.

Add a section to CLAUDE.md describing this workflow so Claude follows it consistently. Sample wording to adapt:

```markdown
## Stakeholder Updates

[NAME] is a [cofounder / client / manager] who is not in these sessions
and reads `Cofounder_Update.md` to stay current.

When the user says "update the stakeholder file," regenerate it:

- Cover **only work since the last update.** Check the date at the top of
  the existing file and read forward from there in the brainstorms.
- Structure it as: what changed, what was decided, what needs [NAME]'s
  input, what's still open.
- Lead with anything that needs a response. Bury nothing.
- Write for someone with full context on the project but zero context on
  these sessions. No internal shorthand, no decision numbers without the
  decision spelled out alongside.
- Keep it scannable. If it runs past a page, it won't get read.
- Stamp it with today's date at the top so the next update knows where to
  start.
```

The load-bearing part is "only work since the last update." A sync file that restates the whole project every time stops being read within a few updates, which defeats the point of having one.

## Phased decision lists

Projects that move through clearly distinct phases (design → build → launch → iterate) benefit from keeping a top-level decisions log per phase.

**Pattern:** Inside each phase folder, add a `Decisions.md` file alongside the `Brainstorm.md` and `Master.md`. It's a flat list of every decision made in that phase, with a one-line summary each:

```markdown
# Phase 1: Foundation — Decisions

- **F1:** Format is two-guest argument structure. (Session 2026-01-04)
- **F2:** Target audience: intermediate home bakers. (Session 2026-01-04)
- **F3:** Episode duration: 25 min, edited tight. (Session 2026-01-08)
- **F4:** Cadence: bi-weekly. (Session 2026-01-08)
- **F5:** No filler episodes. (Session 2026-01-08)
```

The decisions list is a quick-reference index. The Master.md still holds the rationale and context.

When to adopt:
- Phases are clearly distinct and you want each one to have a clean "what we decided here" record
- You're going to refer back to phase 1 decisions from phase 3 frequently

## Test data folders

For projects with sample data that should be kept separate from working files: contributor profiles in a community project, sample dialogues for a writing project, candidate resumes in a hiring project.

**Pattern:** Top-level folder `00_Sample_Data/` or `_Data/` (the `00` prefix sorts it first; the underscore prefix sorts it differently depending on filesystem).

```
00_Sample_Data/
├── README.md              # What's in here, how it's organized
├── person_a/
├── person_b/
└── ...
```

Keep test data completely separate from project thinking files. Claude should treat the data as input, not as something to edit unless explicitly asked.

## Semantic folder names (instead of numbered)

For projects where topics are independent rather than sequential, numbered folders feel arbitrary. Semantic naming is fine:

```
project/
├── CLAUDE.md
├── profile/          # Who I am, what I bring
├── targets/          # Companies/roles/clients in scope
├── outreach/         # Active threads
├── reference/        # Source materials
└── templates/        # Reusable patterns
```

The example above is a job search system, where the folders are genuinely parallel — you work in whichever one the week calls for, and there is no sense in which `outreach` comes after `targets`.

The trade-off is less stable ordering when discussing folders ("the targets folder" vs "folder 03"). For most projects, numbered is the better default. Semantic is the right call when (a) order genuinely doesn't matter and (b) the folder names are self-explanatory enough that numbers don't add anything.

## Multi-language or multi-domain projects

For projects that span multiple disciplines (e.g., a hardware product with hardware, software, and marketing tracks), consider one top-level folder per discipline, with nested topic folders inside:

```
project/
├── CLAUDE.md
├── 01_Hardware/
│   ├── 01_Mechanical/
│   ├── 02_Electronics/
│   └── 03_Manufacturing/
├── 02_Software/
│   ├── 01_Firmware/
│   └── 02_Companion_App/
└── 03_Go_to_Market/
    ├── 01_Positioning/
    └── 02_Launch_Plan/
```

The Brainstorm/Master pair lives at the leaf level. The parent folders are organizational only.

Don't nest more than two levels deep. Beyond that, the structure starts to feel bureaucratic and the navigation cost outweighs the organization benefit.

## Project meta-decisions log

For projects where you want to track decisions about the project itself separately from decisions within the project — choices about workflow, tools, naming conventions, who's involved — add a `META.md` file at the root.

This is different from `Process_Meta_Notes.md`. Meta notes capture workflow observations after the fact. `META.md` captures the deliberate decisions about how the project will be run.

Example contents:
```markdown
# Project Meta-Decisions

- **2026-01-04:** Project lives in Git, private repo, only me has access.
- **2026-01-04:** Sessions are 60-90 minutes max. Two per week.
- **2026-01-08:** Cofounder reads `Cofounder_Update.md` on Sunday evenings.
- **2026-01-15:** Decided not to use the numbered-decision pattern — too small for it.
```

Add this if the project has enough deliberate operational choices to warrant tracking. Skip it otherwise.

## Raw sources next to the summary

Some projects run on material that already exists: message threads, meeting transcripts, exported data, contracts, a folder of documents someone handed you. The Brainstorm/Master pair summarizes it. The summary is not the source of truth; the material is.

**Pattern:** keep the raw material inside the topic folder it belongs to, verbatim, and keep it separate from the files Claude writes.

```
02_Tenants/
├── Brainstorm.md
├── Master.md
├── Person A/
│   ├── thread-export-2026-08-21.json
│   └── 2026-09-02 pasted - follow-up.md
└── Person B/
    └── ...
_source_intake/            (unsorted documents waiting to be filed)
```

Three rules make it work:

- **Verbatim in, summary out.** Raw material is never edited. Anything pasted into a conversation is saved as-is first, with a date in the filename, before any analysis. For anything long, hand Claude the file rather than pasting it; pastes get silently truncated.
- **Go back to the source when detail matters.** A date, an amount, a quote, who said what: Claude re-reads the raw file before answering, without being asked. The template `CLAUDE.md` has this as a start-of-session rule.
- **Said is not true.** Threads record what people said, sometimes for effect. Claims in them, including your own, get checked against the Master before they become facts.

An `_source_intake/` folder at the root is a useful staging area for documents that have not been filed yet. Triage it in a session: file what belongs, flag what doesn't, delete what is not actually part of this project.

When to adopt:
- The project ingests material from outside (threads, transcripts, exports, documents)
- You have caught a summary being wrong about a detail the source had right

## A cold-start brief, a quarantine, and a leak guard

Three related patterns for high-stakes work: a deliverable someone will judge, or material that must not leak into it.

**The cold-start brief.** When a piece of work is important enough that a fresh session getting it wrong would be costly, write one file the session must read completely before anything else. It carries: the file map and reading order; which file wins when two disagree; what is verified and what is not; the working agreement; the open decisions. Put a loud pointer to it at the top of `CLAUDE.md` for as long as the work is live. This replaces the resume point for that work; it is the resume point, written for the worst case.

**The quarantine.** If a previous session produced material that is wrong, unapproved, or built on a false premise, do not delete it and do not leave it where a future session will read it as fact. Move it to a `_quarantine/` folder with a `README.md` saying what is in there and why it is not to be used. Deleting loses the evidence of what went wrong; leaving it in place guarantees the mistake repeats.

**The leak guard.** When deliverables go to an outside party, work in a folder that contains only what is safe to draw from: public material, your own background, what the other party has told you. Anything confidential, and anything from a private conversation that does not also stand on public grounding, stays in a different project. If a session needs to note that such material exists, it writes "captured separately" and the location, not the content. The point is that nothing can enter the deliverable that should not, because it is not there to be found.

When to adopt:
- A deliverable will be judged by someone outside the project
- A prior session got something badly wrong and its output is still on disk
- The project touches material that must not appear in what you send out

## Standing rules inherited from a previous project

If this is not your first cairn project, the previous one taught you things. Some of them are in its `Process_Meta_Notes.md`; the ones that repeated are probably already in its `CLAUDE.md`.

**Pattern:** open the new project's `Process_Meta_Notes.md` with a "Standing Rules" section, ported from the previous project, before any dated entries. Each rule is one line plus the incident that taught it. Reference it from `CLAUDE.md` ("read the standing rules before any significant multi-session work"). New sessions add dated entries below; they do not relitigate the standing rules.

The template `CLAUDE.md` already carries the rules that survived more than one project. This pattern is for the ones that are specific to how *you* work, which no template can know.
