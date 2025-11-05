---
name: plan
description: Break DESIGN.md or PRD into atomic, testable implementation tasks for TODO.md
aliases: [task-plan, breakdown]
enabled: true
---

# PLAN

Transform specifications into actionable, context-rich task lists.

Channel Carmack: "Focus is deciding what you are NOT going to do." Your goal is a TODO.md that any engineer can execute without a meeting.

## Mission

Translate `DESIGN.md`, `TASK.md`, or the latest spec into atomic tasks. Every item must describe a single responsibility, approach, acceptance criteria, tests, and effort estimate.

## Preparation
- Read the latest architecture document end-to-end (`DESIGN.md`, `TASK.md`, or spec summary).
- Identify module boundaries, data contracts, and integration points.
- Scan the repo for patterns to emulate (naming, file layout, test conventions).
- Note external dependencies and order-of-operations risks.

## Decomposition Principles
- **Modularity First**: Each task owns one component/concern. If you need "and" to describe it, split it.
- **Testability**: Define how the work will be verified (unit/integration/E2E). No test plan = incomplete task.
- **Parallel Friendly**: Tasks should be reorderable unless a real dependency exists. Capture prerequisites explicitly.
- **Strategic Balance**: Include refactor checkpoints when architecture introduces new patterns.

## Process

1. **List Modules & Responsibilities**
   - Extract module/component names from the spec.
   - Map dependencies between them; highlight blocking order.

2. **For Each Module, Define a Task Block**
   ```markdown
   - [ ] Implement `UserSessionService`
     ```
     Files: services/user-session.ts, tests/services/user-session.test.ts
     Goal: Provide session issuance/validation per DESIGN.md §2.1
     Pattern: Follow `PasswordResetService` structure (src/services/password-reset.ts)
     Success: API matches interface, session rotation covered, integration tests updated
     Tests: Unit tests for token rotation, integration test for login flow
     Notes: Requires redis client config (see infra/redis.ts)
     Estimate: 1.5h
     ```
   ```

3. **Document Dependencies**
   - Prepend tasks with `[~]` when in-progress, `[x]` once complete.
   - Note cross-module interactions (e.g., "depends on Auth API schema from Task 2").

4. **Capture Open Questions**
   - If a requirement is unclear, add `?` bullet under the task with owner to resolve.
   - Move long-term ideas to `BACKLOG.md`, not TODO.md.

## Quality Bar
- Does each task hide complexity behind clear interfaces?
- Could a new engineer execute it using only the spec + task block?
- Are success criteria binary? ("Passes X test" vs "looks good")
- Are time estimates within 15min–2h? Split anything longer.
- Are naming, patterns, and files grounded in existing code?

## Deliverables
- Updated `TODO.md` with structured tasks, context, and dependencies.
- Optional `BACKLOG.md` entries for out-of-scope improvements.
- Summary note to the user: number of tasks, critical path, estimated effort, risks.

Next step after planning: `/prompts:execute` for the top item or `/prompts:flesh` if any task still feels vague.
