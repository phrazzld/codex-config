---
name: git-respond
description: Triage PR review feedback, plan fixes, and document responses
aliases: [respond, review-comments]
enabled: true
---

# GIT-RESPOND

Systematically analyze PR feedback, categorize each item, and produce an action plan.

## 1. Collect All Feedback
- `gh pr view --json reviewThreads,comments,reviews --jq '.'` to export inline and conversation comments.
- If the PR is huge, paginate: `gh pr view --json reviewThreads --limit 100`.
- Capture reviewer, file path, line, and comment body for every entry.
- Separate bot/automation comments (e.g., lint, Codex) from human feedback; many bots include severity labels.

## 2. Categorize by Urgency
For each comment, decide:
- **Critical / Merge-blocking** – must address before merge.
- **In-scope improvements** – worth fixing in this branch.
- **Follow-up work** – valid but better deferred (move to BACKLOG.md with context).
- **Out-of-scope / Not applicable** – respond with rationale.

Produce a summary like:
```
Critical: 2  |  In-scope: 4  |  Follow-up: 3  |  N/A: 1
```

## 3. Plan Resolutions
- Group related comments by file or theme to minimize context switching.
- For each actionable item, outline the change, tests to run, and expected impact.
- When multiple blockers exist, tackle highest severity first; batch similar updates together.
- If clarification is required, draft questions back to the reviewer before coding.

## 4. Update Tracking Docs
- Add immediate work to `TODO.md` with estimate, files, and acceptance criteria.
- Move deferred ideas to `BACKLOG.md`, referencing the comment URL.
- If new risk or task emerges, note it in the PR description or work log.

## 5. Draft Responses
For every comment, prepare a reply covering:
- Acknowledgement and resolution (e.g., “Fixed in commit abc123 by…”) or
- Reasoning for deferral/rejection with persuasive rationale and next steps.
- Link to TODO/backlog entries when work will continue later.

## 6. Deliver Final Report
- Provide categorized counts and highlight any remaining blockers.
- List completed fixes, follow-up tasks, and unanswered questions.
- Recommend next actions: continue implementing fixes, run `/prompts:code-review`, or request re-review.

Tight, explicit communication keeps reviews moving and builds reviewer trust.
