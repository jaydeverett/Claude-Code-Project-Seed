# Cairn

**The project starter kit for building anything with Claude Code. No prior technical experience required.**

Most people who try to build something real with Claude Code hit the same wall. The first conversation is great. You make progress. You close the window. Two days later you open a new conversation and Claude has no idea what you decided, what you built, or what to do next. You spend ten minutes re-explaining context. By session four, decisions are scattered across multiple chat logs and half-finished files, and you can no longer reconstruct the current state of the project even with effort.

Cairn solves this. It is a folder structure, an instruction file Claude reads automatically, and a session ritual that produces a clean handoff at the end of every conversation. The AI's memory becomes the files. Each session leaves the project in a state the next session can pick up cold. The work compounds across weeks instead of resetting every time.

---

> **Starting with zero technical experience?** Open a Claude conversation and paste this:
>
> > I want to use this for a project but I haven't done anything technical before. Can you help me set it up?
> >
> > https://github.com/jaydeverett/cairn
>
> Claude will walk you through installing everything you need and bring you to the point where cairn's interactive setup flow takes over. See [Starting from absolute zero](#starting-from-absolute-zero) below for the full path.

---

### Already familiar with Claude Code? TL;DR

Clone the repo. Rename the folder. Open Claude Code in it. Type anything. Claude reads `CLAUDE.md`, sees this is a fresh install, runs `SETUP.md` to walk you through 5 questions (about 5 minutes), then writes your customized `CLAUDE.md`, creates your topic folders, and removes itself. After that, the working pattern: one `CLAUDE.md` per project, numbered topic folders each with a `Brainstorm.md` (append-only session log) and `Master.md` (distilled current state), a `Process_Meta_Notes.md` for workflow observations, and a hard rule that every session ends with the user typing "wrap it up" so Claude produces the next-session prompt before context is lost.

See [docs/workflow.md](docs/workflow.md) for the session ritual and [docs/optional-patterns.md](docs/optional-patterns.md) for advanced patterns.

---

## Who this is for

Someone who has tried Claude Code on a real project and watched it go off the rails between conversations. You do not need to be a developer. You do need to be able to use a terminal at the most basic level and clone a repository. The cairn pattern is what happens after that.

Any non-technical person can build something substantial with Claude Code, through to a deployed product, without first becoming a developer. The bottleneck is rarely the AI's capability. The bottleneck is keeping a multi-week project coherent in your head while Claude does the work. After four or five sessions on a real project, most non-technical builders find that their progress has fragmented into incomparable pieces and the current state of the work is opaque to everyone, including them. Cairn is the workflow that prevents this, and with it a beginner can take a project from "I have an idea" through design, build, and ship without losing the thread.

**Secondary: technical people** who want a repeatable scaffold for AI-assisted projects. Same template, less hand-holding in the docs.

## What cairn does

Cairn is the project-thinking layer. It gives you three things:

- One file (`CLAUDE.md`) that Claude reads automatically at the start of every conversation. It tells Claude how this project works.
- One pair of files per topic (`Brainstorm.md` for the running log, `Master.md` for the distilled current state). Together they replace the chat history Claude does not have.
- One ritual at the end of every session ("wrap it up") that produces the next session's starter prompt before context is lost.

There is no software to install beyond Claude Code itself, and no platform to sign up for. Cairn is conventions in a folder, plus an interactive setup flow that customizes those conventions to your specific project.

## What cairn does not do

Cairn handles the navigation. It does not handle the building. Specifically:

- It does not teach you Claude Code. Anthropic's own documentation is at [claude.com/claude-code](https://claude.com/claude-code). Cairn assumes you have the tool installed and can use its basics.
- It does not deploy your project. Whatever you are making, the platforms for putting it into the world sit outside cairn.
- It does not replace the actual thinking. Cairn helps you keep a complex project organized. It does not substitute for doing the work the project requires.

The pitch is precise. Cairn is necessary but not sufficient. It is the layer most non-technical builders miss.

## Beyond cairn

You will need other tools to ship most projects: a code editor, a git host, a deployment platform, whatever else your project specifically requires. You do not need to know which ones before you start. The cairn workflow finds the right tools for the job as the project surfaces them, with Claude recommending specific options based on what your project requires rather than a generic stack you have to choose from upfront.

This is the real leverage. The intimidating-maze feeling of confronting the whole tool ecosystem at once does not happen with cairn, because you encounter tools one at a time, at the moment the project needs them, with a recommendation already in hand.

## How it works

### The two-file pattern

Every topic in your project has two files:

- `Brainstorm.md` is append-only. Every session you have on this topic gets a dated header and entry. You never delete from it. It is the historical record of how thinking evolved.
- `Master.md` is the current-state document. It expresses what you currently believe to be true about this topic, as a standalone readable document. Updated when sessions produce decisions that change the master-level thinking.

The split exists because the running log preserves the *why* (how you arrived at each decision), and the master gives a clean *what* (the current answer) without forcing readers to scroll through five sessions of thinking. They serve different purposes and the project benefits from keeping both.

### The session ritual

Every session has a defined start and end.

**At the start**, you point Claude at a resume point, which is usually a one-paragraph prompt written by Claude at the end of the previous session. Claude reads the relevant files, confirms what it found, and starts working.

**During the session**, Claude flags decisions and open questions explicitly, and stays focused on the topic at hand. If the conversation drifts, Claude flags the drift rather than going along with it.

Sessions come in two modes with different rhythms. **Design sessions** work through questions one at a time — you give a gut answer, it gets pressure-tested, it resolves, next question. **Build sessions** go plan, do one piece, verify it, commit, next piece. The trap in build sessions is finishing convinced that more works than actually works, so verification is part of the rhythm rather than something you get to afterward.

**At the end**, you type "wrap it up." Claude produces five things:

1. An updated `Brainstorm.md` with the new session appended.
2. An updated `Master.md` if anything meaningful changed.
3. A plain-text session summary you can scan.
4. A ready-to-paste prompt for the next session.
5. (Optional) An entry in `Process_Meta_Notes.md` if something notable about the workflow itself happened.

This ritual is what makes cairn work. The whole point of the file structure is to make the wrap-up easy to do, and the wrap-up is what makes the next session pick up cleanly. Skip the ritual and the rest of cairn is a folder of dead files.

### The numbered folders

Top-level folders are numbered (`01_Foundation/`, `02_Production_Setup/`, etc.) and named after the major topics or phases of your project. The numbering gives every folder a stable reference so you can say "in `03_Launch_Strategy`" without ambiguity.

Most projects fit naturally into 4-7 top-level topics. The cairn setup flow will suggest a set based on your project description; you can accept or revise. Other patterns are described in [docs/optional-patterns.md](docs/optional-patterns.md).

## Getting started

There are two paths. Pick the one that matches your starting point.

### Starting from absolute zero

If you have never installed a developer tool, never opened a terminal, and have no idea where to begin: open a Claude conversation and paste this:

> I want to use this for a project but I haven't done anything technical before. Can you help me set it up?
>
> https://github.com/jaydeverett/cairn

Claude will read the README and walk you through the full chain: installing a code editor (typically VS Code), installing Node.js, installing Claude Code, downloading cairn either as a ZIP file or via git, opening Claude Code in the folder, and finally letting cairn's interactive setup flow take over. Claude paces this one step at a time, waits for confirmation at each stage, and adapts to your operating system (Mac, Windows, or Linux).

Two practical notes before you start:

- **You will need a Claude account.** Free works for the setup conversation itself. For running Claude Code on a real project, you will likely want a Claude Pro or Max subscription (simpler, predictable monthly cost) rather than pay-as-you-go API credits. Claude can explain the trade-off during setup.
- **Budget one to two hours for first-time setup**, mostly waiting on installers. After this, you never repeat it.

Once Claude Code is running in your cairn folder, type anything and the interactive setup flow takes over. Five questions, about five minutes, and you have a working project.

### Quick start (if you already have Claude Code)

1. **Get the cairn folder onto your computer.** Either clone the repo with git, download it as a ZIP from the [cairn GitHub page](https://github.com/jaydeverett/cairn) (green "Code" button → "Download ZIP"), or click "Use this template" to make a fresh copy under your own GitHub account.
2. **Rename the folder** from `cairn/` (or `cairn-main/` if you used the ZIP) to your project name.
3. **Open Claude Code in that folder.** Install instructions are at [claude.com/claude-code](https://claude.com/claude-code) if you have not set it up yet.
4. **Type anything to Claude.** `start`, `hi`, `let's go`. Claude will see this is a fresh install, read `SETUP.md`, and walk you through five questions to customize the project.
5. **Answer the questions.** About five minutes total. At the end Claude writes your customized `CLAUDE.md`, creates your topic folders, and offers to start your first session right then.

That is the whole setup. No manual file editing. No folder structure to memorize before you can start. The setup flow is the entry point; the structure underneath it is the cairn pattern.

### Your first session

If you say yes to starting immediately after setup, Claude moves into the first topic you chose and begins asking questions one at a time. When you are ready to stop, type "wrap it up" and Claude produces the deliverables that let your next session resume cleanly: an updated `Brainstorm.md`, an updated `Master.md`, a session summary, and a next-session prompt to paste at the start of next time.

If you would rather come back later, Claude gives you the next-session prompt at the end of setup. Save it somewhere you can find it.

### After session one

Paste the next-session prompt at the start of your next conversation. Claude reads the files, confirms the context, and picks up where you left off. Repeat until the project is done.

## The worked example

A populated example project (a hypothetical podcast called Sourdough Lab) lives at [`.cairn/example/`](.cairn/example/). It shows what two sessions of real thinking look like in the cairn format, including how decisions get numbered (F1, F2...), how open questions get flagged (F-OQ1, F-OQ2...), and how the resume point at the end of each session feeds into the next.

Read it once before your first session if you want to see the shape of filled-in files. It lives in the hidden `.cairn/` directory and does not interfere with your project. Delete it anytime.

## Optional patterns

A few patterns work well for projects beyond the basics but are not part of the minimal template. See [docs/optional-patterns.md](docs/optional-patterns.md) for:

- **Decision and question numbering** (`D1`, `D2`... and `OQ1`, `OQ2`...) for projects with enough accumulated decisions that they need to be referenced across sessions.
- **A build backlog** for projects that have moved from deciding into making, where a decision implies work that outlives the session it was decided in.
- **Incoming feedback files** for projects with collaborators or testers, where a pasted batch of notes would otherwise die with the conversation.
- **Stakeholder sync files** for projects where you regularly update a cofounder, manager, or client.
- **Phased decision lists** for projects that move through clearly distinct phases.
- **Multi-discipline structures** for projects that span hardware, software, and go-to-market tracks.

## Contributing back

If you use cairn for a real project and notice something that worked well, broke down, or could be sharper, open an Issue or a Pull Request on this repo with a meta note. The format is described at the bottom of [`Process_Meta_Notes.md`](Process_Meta_Notes.md). Patterns that show up across multiple contributions get folded into the template.

Share processes, never content. Contribute the workflow lesson, not your project's actual decisions or material. The point is to improve the template, not to publish your work.

This is a manual, low-volume contribution pattern. There is no telemetry, no database, no automatic collection. If usage grows enough that something more structured would be useful, that decision happens later with deliberate design.

## License

MIT. Use freely. Modify freely. Share freely. Credit appreciated but not required.

## A note on origins

Cairn distills a workflow that emerged from running long-running projects with Claude Code across multiple domains over several months. The patterns that survived more than one project are in the template. The patterns that were specific to one project, or that needed more discipline than they were worth, are not.

If you find yourself adding a fifth file type or a tenth folder convention, pause and consider whether you are improving the workflow or just rebuilding the project-specific scaffolding you previously had. The leverage of cairn is in keeping the surface small.
