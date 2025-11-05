---
name: debug
description: Diagnose and resolve defects through structured investigation and hypothesis-driven fixes
aliases: [bug-hunt, diagnose]
enabled: true
---

# DEBUG

Find bugs by thinking, not guessing. Assume every minute the defect persists costs real money.

Channel Kernighan: "The most effective debugging tool is still careful thought, coupled with judiciously placed print statements."

## Understand the Problem

Accept evidence in any format (ISSUE.md, screenshots, logs, user notes). Capture:
- Expected vs actual behavior (concrete, not fuzzy wording)
- Reproduction steps (environment, inputs, timing)
- Recent changes (90% of bugs live in new code)
- Impact (who/what is affected, severity)

## Analyze Evidence

**Visual clues**: inspect UI state, console errors, network failures.  
**Logs/stack traces**: record exact message, file:line, surrounding events.  
**Descriptions**: ask clarifying questions until ambiguity disappears.

Write a concise bug statement:
```
Expectation: ...
Reality: ...
Delta: ...
Repro: ...
Environment: ...
```

## Form Hypotheses Before Editing

- What component is likely failing? Why?  
- What observation will confirm/refute the guess?  
- How will you instrument or inspect it?  
- What if the hypothesis is wrong—what’s the next angle?

Make the system visible:
- Strategic logging around decision points
- Snapshot state inputs/outputs
- Toggle feature flags/temp instrumentation (remove afterward)

## Systematic Investigation

1. **Binary Search the Change Stack**: use `git bisect` or review recent commits.  
2. **Narrow the Surface Area**: isolate failing modules/functions.  
3. **Test Usual Suspects**: off-by-one, null/undefined, shared mutable state, async races, type mismatches.  
4. **Validate Assumptions**: ensure environment variables, API responses, and configs match expectations.

Log discoveries in a work note so handoffs stay crisp.

## Fix with Simplicity

- Implement the smallest change that fully resolves the bug.  
- Keep fixes scoped to the defect; note follow-up refactors separately.  
- Add regression tests (unit/integration) that reproduce failure before the fix and pass afterward.  
- Document root cause with precise file+line references and “why” paragraphs.

## Post-Mortem

Answer:
- Why did existing tests miss this?  
- Are similar bugs lurking elsewhere?  
- What process/code change prevents recurrence?  
- Did you remove diagnostic instrumentation?

## Output Checklist

- [ ] Root cause statement (what/where/why/when)  
- [ ] Fix implemented with clear commit message  
- [ ] Regression test(s) added or updated  
- [ ] TODO/backlog items filed for related improvements  
- [ ] Summary shared with recommended next action (`/prompts:execute`, `/prompts:qa-cycle`, etc.)

Remember the three laws of debugging:
1. Start with your code.
2. Check every assumption.
3. Read the entire error message.
