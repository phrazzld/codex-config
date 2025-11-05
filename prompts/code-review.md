---
name: code-review
description: Run a two-phase self-review to clean changes, surface risks, and generate actionable follow-ups
aliases: [git-code-review, review]
enabled: true
---

# CODE-REVIEW

Comprehensive quality review: clean up first, then scrutinize every decision.

## Review Scope
- Define what you’re reviewing: PR diff, current branch vs `main`, or last commit.
- Use `git diff --stat` and `git diff --name-only` to understand breadth.
- Note affected modules, architectures, and dependencies.

## Phase 1: Cleanup (Matt Shumer’s Rule)

"After completing your goal, clean up the code, remove bloat, and document clearly."

Remove:
- Debug statements, temporary logs, commented-out code
- Dead imports, unused vars, redundant configuration
- Inconsistent naming, magic numbers without context
- Temporary hacks—if it must stay, document why

Goal: code you’d be proud to ship publicly.

## Phase 2: Brutal Honesty (Daniel Jeffries)

Pretend it is **not** production-ready. Ask:
- Where is magical thinking or hand-waving?
- What edge cases fail at 3 AM?
- Where did you copy-paste without fully understanding?
- What assumptions threaten user data, security, or UX?

Probe key axes:
- **Security**: data exposure, missing validation, injection vectors
- **Performance**: accidental O(n²), tight loops, unbounded queues
- **Error Handling**: swallowed errors, silent failures
- **Testing**: do tests prove behavior or just pass?
- **Architecture**: coupling so tight it needs therapy?

## Phase 3: Ousterhout Red Flags

Scan for:
1. **Information Leakage** – interfaces exposing implementation details.
2. **Temporal Decomposition** – code organized by execution order instead of responsibility.
3. **Generic Names** – `Manager`, `Util`, `Helper` dumping grounds.
4. **Pass-through Layers** – wrappers that just forward calls.
5. **Configuration Overload** – callers forced to know internals.
6. **Shallow Modules** – interface complexity ≈ implementation complexity.

Document each violation, location, consequence, and fix.

## Phase 4: Principle Compliance

Score each pillar (write quick notes):
- **Simplicity (30%)** – simplest solution? Avoid cleverness.
- **Explicitness (25%)** – dependencies + side effects visible?
- **Modularity (25%)** – clear boundaries, high cohesion, low coupling?
- **Maintainability (20%)** – naming, docs, clarity for future you?

Call out low-scoring areas with actionable remediation.

## Phase 5: Technology-Specific Checks

- Type safety (TS `any`, unchecked casts, ignored errors)
- Layering (no infra details in domain logic, no circular deps)
- Testing sufficiency (happy path + edge cases)
- Performance hotspots (N+1 queries, missing indexes)
- Backward compatibility (API/contract changes communicated)

## Categorize Findings

Group feedback:
- **BLOCKERS** – breaks production, security risk, data loss, migration gaps.
- **IMPROVEMENTS** – required before merge (missing tests, brittle logic).
- **POLISH** – optional cleanups or future refactors.

Express as TODOs:
```markdown
- [ ] [CRITICAL] Handle ignored error in api/handler.go:89  
  Principle: Explicitness (silent failure)  
  Fix: Propagate error or log with context, add regression test  
  Time: 15m
```

## Score & Decision

Provide overall rating:
- 90–100 Exceptional (ready)
- 70–89 Minor fixes
- 50–69 Significant revisions
- <50 Major rework

State merge decision (APPROVE vs BLOCKED) with justification and required fixes.

## Deliverables
- Summary of cleaned changes + remaining concerns
- TODO list or review comments with severity
- Recommendation on merge, additional tests, or follow-up tasks

Brutal honesty now saves days of firefighting later.
