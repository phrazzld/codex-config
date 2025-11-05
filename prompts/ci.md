---
name: ci
description: Diagnose failing CI runs, distinguish code vs infrastructure issues, and generate resolution tasks
aliases: [ci-fix, pipeline]
enabled: true
---

# CI

Check the pipeline, capture evidence, and build an actionable recovery plan.

## 1. Inspect Status
- `gh pr checks` or `gh run list --limit 5` to view recent runs.
- For a specific run: `gh run view <run-id> --log`.
- If checks are still running, wait briefly before re-evaluating; avoid thrashing.

## 2. Capture Failure Details
- Download logs/artifacts for failed jobs.
- Note: workflow name, job, step, command, exit code, timestamps.
- Extract key error messages, stack traces, and affected files.
- Record branch SHA and environment info (OS image, node/python version, secrets, etc.).
- Summarize findings in a scratch buffer (delete later) so context is centralized.

## 3. Classify Failure Type
Decide whether the failure is:
- **Code Issue** – regressions introduced by the branch (failing tests, lint errors, missing deps).
- **CI Infrastructure** – flaky tests, environment drift, resource limits, network/service outages, misconfigured pipelines.

Support classification with evidence (`git blame`, historical run history, known flaky tests).

## 4. Write the Resolution Plan
Document:
- Root cause hypothesis (code vs CI infra).
- Reproduction steps locally (commands, inputs).
- Verification steps once fixed (tests to rerun, pipelines to trigger).
- Potential blast radius or risks if unfixed.

Consider multiple hypotheses if evidence is thin; prioritize by likelihood.

## 5. Generate Tasks
Translate the plan into TODO entries with labels:
- `[CODE FIX]` for changes to application/tests.
- `[CI FIX]` for pipeline or environment adjustments.
Each task needs files to touch, approach, test/verification, and owner/estimate.
Move long-term improvements or flaky test refactors to `BACKLOG.md`.

## 6. Communicate
- Update PR description or CI-FAILURE summary with current status, root cause, and next steps.
- If assistance needed, include log snippets and hypotheses in the message.
- Call out blockers and expected ETA for resolution.

Finish with a clear recommendation: rerun CI after fix, coordinate infra support, or mark checks as expected failures (with justification).
