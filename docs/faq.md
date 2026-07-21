# FAQ

For non-technical users adopting cairn for the first time.

### Do I need to know how to code to use this?

No. Cairn is a folder of text files and a `CLAUDE.md` file that the AI reads. You edit the files in any text editor. You can use cairn for a podcast, a novel, a wedding, a renovation, a job search, a fundraiser, or anything else.

If you want to use git to keep history of your project (recommended but not required), you'll need to install git and learn a handful of commands. There are friendlier tools — GitHub Desktop is free and visual, and the cairn repo will work fine with it.

### Do I need Claude Code specifically, or does this work with regular Claude?

Cairn is designed for **Claude Code**, the command-line tool, because it reads `CLAUDE.md` automatically and can edit files for you. It will also work with **Claude.ai** in the browser if you manually paste in the `CLAUDE.md` content at the start of each session and copy/paste file contents in and out — but this is much more friction. If you're going to use cairn seriously, set up Claude Code. Anthropic's installation guide is at [claude.com/claude-code](https://claude.com/claude-code).

(The pattern will also work with other AI assistants — Cursor, Aider, even ChatGPT with file uploads — but the file-editing automation is best in Claude Code.)

### What if my project is small? Do I really need five folders?

No. Use as few as you need. A single-topic project might have one folder (just `01_Project/`) plus the root files. Cairn scales down. The numbered-folder pattern is the default because most projects benefit from separating distinct topics, but it's not a requirement.

### What if my project is huge?

Cairn scales up well to about 7-10 top-level folders. Beyond that, nest them: `01_Product/01_Design/`, `01_Product/02_Engineering/`. The Brainstorm/Master pair pattern works at any level.

For projects with hundreds of decisions, consider adding the optional decision-numbering pattern (`D1`, `D2`, `OQ1`, `OQ2`) so things can be referenced precisely. See [optional-patterns.md](optional-patterns.md).

### My session went on a tangent and we worked on the wrong topic. What now?

Two options:
1. **Move the session entry** to the folder it actually belongs in. The dated session header survives the move.
2. **Leave it and note the drift in both folders.** Add a short note in the original folder's brainstorm: "Session went off-topic into [other topic] — entry moved to [other folder]/Brainstorm.md."

The second option is cleaner if the drift was substantive.

### Can I run two sessions in parallel? E.g., one in the foundation folder while another runs in the production folder?

Yes, but only with a specific discipline, and the default answer is still one at a time.

The failure mode is two sessions writing the same file and silently clobbering each other. What makes it safe is boring and non-negotiable:

- **Split file ownership explicitly.** Before starting, tell each session which files it owns and which it must not touch. Name them.
- **If a session needs a file it doesn't own, it stops and tells you** rather than reaching in. You pause the other session, let the change happen, resume.
- **Shared files go last.** `Master.md`, `Process_Meta_Notes.md`, anything at the project root — whichever session wraps second updates those, after the first has finished.
- **If you use git, give each session its own branch** and merge when both land.

This works well when the two tracks are genuinely separate. It costs you more than it saves when they aren't. If two sessions keep needing each other's files, that's a sign it was one session all along.

### How do I know work isn't getting dropped between sessions?

If you're asking this, something probably is. It's the most common complaint on projects past the first month, and it usually has a specific cause: the *decisions* are safe in `Master.md`, but the *work those decisions imply* was only ever tracked in the session's head.

The fix is a `BACKLOG.md` — see [optional-patterns.md](optional-patterns.md). The important part isn't the file, it's the timing: every decision becomes a backlog line at the moment it's made, not during cleanup later.

Also worth knowing: when you check whether something got done, check the actual work, not another document that says it was done. Status documents copy each other's mistakes, in both directions — things marked finished that were never built, and things marked pending that shipped weeks ago.

### What if I don't have a "resume point" because I closed the last session without wrapping?

Use the [`docs/starter-prompts.md`](starter-prompts.md) "Resuming after the first session (no resume point yet)" prompt. Tell Claude to read the most recent session in the relevant Brainstorm.md and pick up from there. You'll lose 5-10 minutes of re-orientation but the work is recoverable as long as the Brainstorm.md entry was written.

If the previous session ended without a Brainstorm.md update — i.e., you really did just close the chat — that session's thinking is gone. This is the failure mode the wrap-up ritual exists to prevent. From now on, treat "wrap it up" as non-negotiable.

### How long should a session be?

Most useful sessions are 30-90 minutes. Under 30 minutes and you barely have time to dig into one question. Over 90 minutes and either (a) you're tired and quality drops, or (b) Claude's context window starts filling up and quality drops on its side too. The natural unit is 2-5 substantive questions resolved.

If you have more than 90 minutes of work, do two sessions back-to-back with a wrap in between. The second session starts cleanly with the next-session prompt from the first.

### How often should I update the Master.md?

In the same session as the decision that changes it. Don't batch. The brainstorm-vs-master drift is real and painful to recover from after 4-5 sessions of accumulated changes.

If the Master.md changes are big, the wrap step naturally produces them. If they're small, do them inline.

### What do I do with the example "Sourdough Lab" content?

It lives in `.cairn/example/` after setup — out of your way, but readable if you want to see what filled-in `Brainstorm.md` and `Master.md` files look like. Two sessions of a hypothetical podcast project, showing decision numbering, open question tracking, and the resume-point pattern.

Read it once before your first session if you want a reference. Delete `.cairn/example/` whenever you don't need it anymore — it doesn't affect your project.

### What if Claude doesn't follow the workflow?

Three things to try:
1. **Be more explicit.** Some Claude versions or modes default to being chattier than the cairn workflow wants. A direct instruction like "follow the cairn workflow exactly — one question at a time, wrap when I say wrap" usually corrects this.
2. **Check that Claude actually read CLAUDE.md.** In some setups, especially Claude.ai in the browser, you need to manually upload or paste it at the start of each session. In Claude Code in the terminal, it should be automatic.
3. **Update CLAUDE.md.** If Claude keeps doing something you don't want, that's a signal to add a "Do not [behavior]" line to your CLAUDE.md. The instruction file is supposed to evolve with your project.

### Can I share my finished project's brainstorm + master files with someone else?

Yes. The files are plain markdown. Anyone with a text editor can read them. This is part of the point — the cairn structure makes a project legible to humans, not just to AI.

If your project is private, keep the repository private. If it's something you want to share (a public project journal, a transparent decision log for a community), you can make the repository public on GitHub.

### What does cairn cost?

Cairn itself is free and open-source. Claude Code or Claude.ai has its own pricing — see Anthropic's site. Most of cairn's value is in the conventions, not in any code, so there's no service to pay for.

### How is this different from just using Notion / Obsidian / Google Docs?

You can absolutely use those tools to take notes on a Claude conversation. Cairn is different because:
- The AI reads the structure directly and follows the workflow. Notion or Obsidian require you to copy-paste content in and out.
- The files live in your filesystem where Claude Code can edit them. No round-trip needed.
- The conventions are the leverage, not the tool. You could implement cairn in Notion if you wanted to — it's the workflow that matters, the markdown files are just the cleanest way to make it work today.

That said: if you already have a strong note system in Notion or Obsidian, cairn can coexist. Use cairn for the AI-collaboration layer (files Claude reads and edits), and keep your other system for personal notes that aren't part of the AI loop.

### I want to contribute back. How?

Open an Issue or Pull Request on the cairn GitHub repo with a meta note in the format described in [`Process_Meta_Notes.md`](../Process_Meta_Notes.md). Share the workflow lesson, not your project's content.

Useful contributions get folded into the README. Useful enough to be on the main README is a higher bar than useful enough to be discussed in an Issue — both are welcome.
