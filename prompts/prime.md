---
name: prime
description: Rapidly gather repository, task, and pattern context before making changes
aliases: [prep, context]
enabled: true
---

# PRIME

Load context. Understand everything. Write nothing.

Use this command before touching code so every later decision starts from ground truth.

## The Readiness Principle

*"Measure twice, cut once."* Context work prevents rework. A 10-minute recon can save a day of backtracking.

## 1. Project State Analysis
- Run `git status --short` and note untracked/modified files
- Compare against main branch: `git log --oneline main..HEAD | head -10`
- Record current branch, tracking status, and pending merges
- Identify project type (framework, language, build system) from `package.json`, `pyproject.toml`, etc.

## 2. Task Intelligence
- Read `TODO.md` (or project task file) for current commitments
- Check for `BACKLOG.md` / `TASK.md` / `ISSUE.md` and summarize outstanding work
- Tag blockers or dependencies that must be resolved first
- Classify each task: quick win, deep work, needs clarification

## 3. Contextual Research
- Review `README.md`, `CLAUDE.md`/`AGENTS.md`, CONTRIBUTING docs, and team principles
- Capture testing/formatting commands, release process, and quality gates
- If search is available (e.g., Exa, web browser), gather current best practices for the tech in play
- Note company-specific standards, naming conventions, and architectural patterns

## 4. Pattern Discovery
- Use `rg`, `fd`, or IDE search to identify module boundaries, naming schemes, and file layouts
- Determine test framework (Vitest, Jest, Go test, etc.) and common helpers
- Locate shared utilities, domain models, and configuration patterns
- Map out build/lint/format commands and any required environment variables

## 5. Output Readiness Report

Summarize the situation in tight bullet points:
- **Current Context**: branch, divergence from main, notable local changes
- **Next Tasks**: actionable TODO items with owners or status
- **Key Patterns**: conventions you must follow (naming, architecture, testing)
- **Blockers**: risks, missing information, failing checks
- **Recommended Next Command**: e.g., `/prompts:spec`, `/prompts:plan`, `/prompts:execute`

Remember: context is king. Understanding prevents mistakes. Prime once; work faster all day.
