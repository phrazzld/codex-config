---
name: pr
description: Summarize branch changes and generate a crisp pull request title and body before publishing
aliases: [git-pr, pull-request]
enabled: true
---

# PR

Create a pull request with a punchy title and comprehensive description derived from the branch history.

## 1. Analyze Branch Changes
- `git log main..HEAD --oneline` → snapshot of commit themes
- `git log main..HEAD --pretty=format:"%h %s%n%b" --no-merges` → detailed commit context
- `git diff --name-only main..HEAD` → files touched
- `git diff --stat main..HEAD` → magnitude of change
- Capture test results or QA notes from recent runs

## 2. Craft the Title
- Synthesize the branch’s core outcome in ≤50 characters.
- Use action verbs + scope (e.g., “Add JWT auth for API users”).
- Avoid filler (“Updates”, “Misc changes”, “Fix stuff”).
- Verify the title reflects user impact, not implementation trivia.

## 3. Write the Description

Structure:
```markdown
## Summary
[2–3 sentences: what changed, why it matters, user impact]

## Changes Made
- [High-level change + outcome]
- [High-level change + outcome]
- [High-level change + outcome]

## Technical Notes
- Key architectural decisions or trade-offs
- Migrations/backfills/config changes
- Follow-up work or limitations

## Testing
- [ ] Unit: describe suites or commands run
- [ ] Integration/E2E: list scenarios
- [ ] Regression checks
- [ ] Additional validation (manual QA, screenshots, recordings)

## Review Focus
- Direct reviewers to critical files, risks, or areas needing scrutiny
```

Populate the checklist with actual results (replace `[ ]` with `[x]` where complete).

## 4. Create the PR (optional automation)
- `gh pr create --draft --assignee phrazzld --title "..." --body "$(cat pr-body.md)"`  
  (Create `pr-body.md` temporarily or pipe directly.)
- Tag relevant labels, projects, reviewers.
- Keep PR in draft until CI + manual validation pass.

## 5. Report Back
- Share the PR URL, title, and any outstanding follow-ups.
- Note next steps: CI status, review focus, deployment considerations.

Remember: a good PR tells reviewers exactly what changed and why it matters before they read the diff.
