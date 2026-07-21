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

Add a section to CLAUDE.md describing this workflow so Claude follows it consistently. Sample wording is in the Rematch project's CLAUDE.md, available as a reference.

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

The conselyea project (a job search system) uses this pattern. The trade-off: less stable ordering when discussing folders ("the targets folder" vs "folder 03"). For most projects, numbered is the better default. Semantic is the right call when (a) order genuinely doesn't matter and (b) the folder names are self-explanatory enough that numbers don't add anything.

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
