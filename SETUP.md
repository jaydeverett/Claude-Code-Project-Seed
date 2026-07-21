# Cairn Setup

**This file is a setup script for Claude. If you are a human reading this, just type "start" (or anything) in Claude Code and Claude will walk you through setup.**

---

## INSTRUCTIONS TO CLAUDE

You are running the cairn setup flow. The user has cloned the cairn template and is starting from a fresh install. Your job is to walk them through 5 questions, one at a time, and at the end produce a customized `CLAUDE.md`, create their topic folders, and remove this setup script.

**Critical rules:**

1. **One question at a time.** Do not batch. Wait for the user's answer before moving to the next question.
2. **Confirm understanding after each answer.** Echo back what you understood in 1-2 sentences. Let them correct you before moving on.
3. **Use plain language.** Many users will be non-technical. Avoid jargon. If a technical term is necessary, define it inline.
4. **Take a position when asked.** If the user asks "what should I pick?" — recommend something specific with one sentence of reasoning. Don't enumerate options.
5. **Be quick.** This should take 5 minutes, not 30. If an answer is "good enough," move on rather than perfecting it.

---

## Step 1 — Welcome the user

On the user's first message in this conversation (regardless of what they say), greet them and explain what's about to happen. Keep it brief:

> "Welcome to cairn. I'm going to ask you 5 quick questions to set this up as a real project. By the end (about 5 minutes), you'll have a working project structure customized for you, and we can either start the first session immediately or stop and come back later. Ready?"

Wait for the user to confirm before continuing.

---

## Step 2 — Q1: What is this project?

Ask:

> "First question: in a few sentences, tell me what this project is. What are you working on, who is it for, and what would a good outcome look like? Don't overthink it — a rough answer is fine, we can sharpen it later."

After the answer:
- Extract: a short name (1-3 words) that can be used as a project title and folder name
- Extract: a 2-4 sentence description suitable for the "What This Project Is" section of CLAUDE.md
- If the user's answer is vague (e.g., "a podcast"), ask one follow-up: "Got it. What's the angle or focus? What makes it specific?"
- Confirm: "So this is **[NAME]** — [one-sentence summary]. Sound right?"

Wait for confirmation. Adjust if needed.

---

## Step 3 — Q2: What phase are you in?

Ask:

> "Second question: what phase is this project in right now? Pick whichever fits best:
> - **Concept** — still figuring out what this is
> - **Design** — the concept is clear, now planning the details
> - **Build** — actively making it
> - **Launch** — getting it in front of people
> - **Iteration** — it's out there and you're improving it
> - **Open-ended** — none of the above, or it's an ongoing thing
>
> One word is enough."

After the answer, confirm: "Got it, **[PHASE]**. Moving on."

---

## Step 4 — Q3: What are the major topics or phases?

This is the most important question. The answer determines the folder structure.

Ask:

> "Third question: what are the major topics or phases of this project? Pick 4-7 — these will become the top-level folders. They can be phases you work through in order, or independent areas of work that all happen in parallel.
>
> If you're not sure, I can suggest some based on what you told me. Want me to suggest?"

If the user wants suggestions: based on Q1 (project description) and Q2 (phase), propose 4-6 topic folders. Use phase-based naming if the project is sequential, domain-based naming if it's parallel. Examples to draw from:

- Phase-based: `Concept`, `Design`, `Build`, `Launch`, `Iteration`
- Domain-based: `Strategy`, `Product`, `Operations`, `Marketing`, `Finance`
- Audience-based: `Internal`, `Customers`, `Partners`, `Investors`
- Creative project (writing/podcast/film): `Foundation`, `Production`, `Distribution`, `Audience`, `Growth`
- Service business: `Positioning`, `Offers`, `Marketing`, `Operations`, `Clients`
- Personal life project (wedding, move, etc.): split by phase or by stakeholder

Present 4-6 suggestions to the user. Confirm or let them edit. If they want different topics, accept their list — don't push back unless it's obviously off (e.g., 15 topics, or a single topic that's clearly too narrow).

Finalize the list. Confirm: "Got it. We'll create these folders: **01_[Topic1]**, **02_[Topic2]**, ..."

---

## Step 5 — Q4: Where do you want to start?

Ask:

> "Fourth question: which topic do you want to work on first? Most projects benefit from starting at the foundational topic — clarifying what you're building before getting into the details — but you can start anywhere."

After the answer, note the topic. Do not change the folder numbering — the user's chosen first topic might be `03_[Something]` even though it's the first one they'll work in. That's fine.

Confirm: "Starting with **[TOPIC]**. Got it."

---

## Step 6 — Q5: Anything else?

Ask:

> "Last question: anything project-specific I should know that would shape how I help you? Examples: principles you've already decided, terminology unique to this project, stakeholders you sync with regularly, or anything else that's load-bearing for the work.
>
> If nothing comes to mind, that's fine — just say 'nothing.' You can always add this later."

Accept the answer. If they provide content, capture it for the "Project-Specific Notes" section of CLAUDE.md. If they say "nothing," that section gets a placeholder line.

---

## Step 7 — Confirm the plan

Summarize the full plan back to the user in a structured way:

> "Here's what I'm going to set up:
>
> **Project:** [Name]
> **Description:** [2-4 sentence description]
> **Phase:** [Phase]
> **Topic folders:** [List]
> **Starting with:** [Topic]
> **Project-specific notes:** [Captured notes, or 'none for now']
>
> Shall I create this?"

If yes, proceed. If they want to change anything, make the change and re-confirm.

---

## Step 8 — Apply the setup

Once confirmed, perform these actions:

1. **Read** `.cairn/claude-template.md`.

2. **Substitute placeholders** in the template:
   - `{{PROJECT_NAME}}` → the user's project name
   - `{{SETUP_DATE}}` → today's date (YYYY-MM-DD)
   - `{{PROJECT_DESCRIPTION}}` → the 2-4 sentence description
   - `{{PROJECT_PHASE}}` → the phase
   - `{{TOPIC_FOLDER_TREE}}` → a tree representation of the topic folders, formatted like:
     ```
     ├── 01_[Topic1]/
     │   ├── Brainstorm.md
     │   └── Master.md
     ├── 02_[Topic2]/
     │   ├── Brainstorm.md
     │   └── Master.md
     ```
   - `{{PROJECT_SPECIFIC_NOTES}}` → the user's Q5 answer, formatted as readable prose or bullet points. If they said "nothing," write: "_None yet. Add notes here as the project evolves._"

3. **Write the result** to `CLAUDE.md` (replacing the current pointer file).

4. **For each topic folder**, create the folder and populate it:
   - Folder name format: `01_[TopicName]/` where TopicName is the user's name with underscores instead of spaces, in Title_Case. Example: "Production Setup" → `02_Production_Setup/`.
   - Inside each folder, create `Brainstorm.md` by reading `.cairn/brainstorm-skeleton.md` and substituting:
     - `{{TOPIC_NAME}}` → the topic name (with spaces, not underscores; for the heading)
     - `{{TOPIC_DESCRIPTION}}` → a one-line description of what this topic covers. Generate something reasonable based on the topic name.
   - Create `Master.md` the same way using `.cairn/master-skeleton.md`.

5. **Delete `SETUP.md`** — it has done its job.

6. **Tell the user**:

   > "Setup complete. Here's where things are:
   >
   > - `CLAUDE.md` — your project's instruction file (Claude reads this every session)
   > - `01_[Topic1]/`, `02_[Topic2]/`, ... — your topic folders, ready for content
   > - `Process_Meta_Notes.md` — for workflow observations as you go
   > - `docs/` — references on the workflow itself
   > - `.cairn/example/` — a worked example you can read for reference (delete it anytime)
   >
   > Want to start your first session now? It would be on **[STARTING_TOPIC]**, and I'd begin by asking you the first foundational question for that topic. If you'd rather come back later, here's the prompt to paste at the start of your next session:
   >
   > ```
   > Start session on [STARTING_TOPIC]. Read CLAUDE.md and [folder]/Brainstorm.md, then ask me one question at a time to begin filling in this topic.
   > ```"

---

## Step 9 — Offer the wrap reminder

After the setup summary, make one offer. This is not a sixth question — it's a yes/no, and "no" is a perfectly good answer.

> "One last thing, optional. The whole workflow depends on you typing 'wrap it up' before you close a session — that's the step that saves your work. It's also the easiest one to forget, and forgetting it loses the session.
>
> I can install a reminder that nudges me to offer a wrap-up when a session has run long or when the conversation gets full. It's a small script that already lives in this folder at `.cairn/hooks/wrap-reminder.sh` — you can read it, it's commented. It only talks to me, never blocks anything, and doesn't touch the network.
>
> Want it on? (You can add or remove it anytime.)"

**If yes**, write `.claude/settings.local.json`. Merge with the existing file if there is one — do not overwrite settings the user already has:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          { "type": "command", "command": "\"$CLAUDE_PROJECT_DIR/.cairn/hooks/wrap-reminder.sh\"" }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          { "type": "command", "command": "\"$CLAUDE_PROJECT_DIR/.cairn/hooks/wrap-reminder.sh\"" }
        ]
      }
    ]
  }
}
```

Then tell them: "Done. It'll take effect next session. If it ever gets annoying, tell me to remove the wrap reminder and I'll delete it — or change how long it waits by setting `CAIRN_WRAP_AFTER_TURNS` (default is 25 turns)."

**If no**, say "No problem — the reminder is off. You can ask me to turn it on later," and move on. Do not press.

**Why the file is local and not committed:** `.claude/settings.local.json` is gitignored, so it stays on this machine and never ships to anyone who clones the project. This matters. Hooks are shell commands that run automatically, so a template that ships them pre-wired would execute code on every person who cloned it, before they had any chance to look at it. Cairn ships the script inert and asks first. If the user asks why, that's the honest answer — and it's the same reason they should be wary of any other repo that arrives with hooks already turned on.

---

## Step 10 — (Optional) Start the first session

If the user wants to start immediately, transition smoothly into the first session for their starting topic. Begin by asking what they consider the most important foundational question for that topic. From here, the regular cairn session workflow takes over (now described in the newly-written CLAUDE.md).

---

## Failure modes to watch for

- **User wants to skip a question.** That's fine. Mark it as "to be filled in later" and move on. Don't block.
- **User gives a long, rambling answer.** Extract the signal, summarize back what you understood, confirm, and move on. Don't try to use the full answer verbatim.
- **User wants to add many more topics than 7.** Suggest grouping them. If they insist, accept it but note that very large folder lists become hard to navigate. Don't argue.
- **User asks about advanced patterns** (decision numbering, stakeholder files, etc.) during setup. Briefly mention they exist in `docs/optional-patterns.md` and can be added later. Do not configure them now — keep setup minimal.
- **Something fails during file creation.** Tell the user clearly what failed and what state things are in. Do not silently continue.
