# Codex CLI Configuration

OpenAI Codex CLI setup with workflows, prompts, slash commands, and profiles ported from Claude Code.

## Quick Start

```bash
# Use a profile
codex --profile ultrathink "review this architecture"
codex --profile execute "implement next task"
codex --profile ship "complete feature workflow"

# Use custom prompts
codex "/prompts:ultrathink"
codex "/prompts:ship"
codex "/prompts:architect"
codex "/prompts:execute"
codex "/prompts:doctor"
```

## Repository Layout

- `config/` – Canonical CLI configuration (`config.toml`, `config.json`) plus MCP blocks
- `prompts/` – Top-level prompt + slash markdown (Codex loads filenames directly) with metadata in `prompts/index.json`
- `scripts/` – Operational tooling (`doctor`, `lint-config`, `check-prompts`, `check-mcp-exa`)
- `secrets/` – Non-committed env stubs (copy `exa.env.example` → `exa.env`, export before use)
- `docs/CHANGELOG.md` – Versioned history for repo changes

## Profiles

Configured in `config/config.toml`, profiles switch between different model and approval settings:

### **ultrathink** - Deep Architectural Review
- Model: GPT-5
- Reasoning: High
- Approval: On-request
- Use for: Design critique, complexity analysis, architecture decisions

### **execute** - Tactical Implementation
- Model: GPT-5-Codex
- Reasoning: Medium
- Approval: On-failure
- Use for: Task execution, feature implementation, coding work

### **ship** - Complete Workflows
- Model: GPT-5-Codex
- Reasoning: High
- Approval: Untrusted
- Use for: End-to-end feature delivery, spec → implementation → PR

### **fast** - Quick Tasks
- Model: GPT-5
- Reasoning: Low
- Approval: On-failure
- Use for: Quick edits, simple refactors, minor fixes

## Custom Prompts

All command markdown lives directly in `prompts/`. Categories below reflect naming conventions used in `prompts/index.json`.

### Workflow

- **/prompts:prime** - Recon current branch, tasks, and conventions before acting
- **/prompts:spec** - Investigate, compare alternatives, and produce a PRD
- **/prompts:plan** - Break the PRD into atomic TODO.md tasks with tests and estimates
- **/prompts:architect** - Transform PRD into module design + pseudocode
- **/prompts:flesh** - Make vague TODOs executable and scoped
- **/prompts:execute** - Implement the next task with tactical focus
- **/prompts:ship** - Orchestrate end-to-end feature delivery
- **/prompts:debug** - Diagnose defects through hypothesis-driven investigation

### Quality

- **/prompts:qa-cycle** - Integrated manual QA with inline debugging
- **/prompts:pr-ready** - Automated quality gate validation

### Review

- **/prompts:ultrathink** - Deep critical evaluation of designs for simplicity and complexity
- **/prompts:ousterhout** - Spot shallow modules, leakage, red flags
- **/prompts:testing** - Review tests for behavior vs implementation
- **/prompts:code-review** - Two-phase cleanup + brutal honesty self-review

### Git

- **/prompts:pr** - Generate crisp PR titles/bodies and share next steps
- **/prompts:git-respond** - Triage review feedback and craft action plan + replies
- **/prompts:ci** - Investigate failing checks and produce resolution tasks

### Slash Commands

- **/prompts:doctor** - Environment doctor summarizing git/config/prompt/MCP health

## Example Workflows

### Complete Feature Development

```bash
# High-reasoning full workflow
codex --profile ship "/prompts:ship"

# Or step-by-step:
codex "/prompts:prime"      # Recon project state and conventions
codex "/prompts:spec"       # Produce the PRD with alternatives
codex "/prompts:plan"       # Build TODO.md from DESIGN/TASK
codex "/prompts:flesh"      # Clarify any vague tasks
codex "/prompts:execute"    # Implement the next task
codex "/prompts:debug"      # Optional: use for active bug hunts
codex "/prompts:qa-cycle"   # Test and fix
codex "/prompts:pr"         # Draft PR title + body
codex "/prompts:code-review"# Brutal self-review before handoff
codex "/prompts:pr-ready"   # Final quality gate
```

### Design Review

```bash
codex --profile ultrathink "/prompts:ultrathink"
```

### Task Execution

```bash
codex --profile execute "/prompts:execute"
```

### Code Review

```bash
codex "/prompts:ousterhout"  # Check module depth, info hiding
codex "/prompts:testing"      # Review test quality
```

## Shell Aliases

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
# Codex with profiles
alias cdx='codex'
alias cdx-think='codex --profile ultrathink'
alias cdx-exec='codex --profile execute'
alias cdx-ship='codex --profile ship'
alias cdx-fast='codex --profile fast'

# Common prompts
alias cdx-ultra='codex "/prompts:ultrathink"'
alias cdx-arch='codex "/prompts:architect"'
alias cdx-prime='codex "/prompts:prime"'
alias cdx-spec='codex "/prompts:spec"'
alias cdx-plan='codex "/prompts:plan"'
alias cdx-do='codex "/prompts:execute"'
alias cdx-qa='codex "/prompts:qa-cycle"'
alias cdx-ready='codex "/prompts:pr-ready"'
alias cdx-debug='codex "/prompts:debug"'
alias cdx-pr='codex "/prompts:pr"'
alias cdx-review='codex "/prompts:code-review"'
alias cdx-respond='codex "/prompts:git-respond"'
alias cdx-ci='codex "/prompts:ci"'
```

Then reload: `source ~/.zshrc`

## Slash Commands

- Codex only reads markdown directly under `~/.codex/prompts/`; keep slash command files (e.g. `prompts/doctor.md`) at the top level.
- Run `scripts/check-prompts.sh` to ensure every entry listed in `prompts/index.json` has a matching file with front matter.
- Add new slash commands by placing a markdown file in `prompts/` and adding metadata to `prompts/index.json`.

## EXA MCP Integration

1. Copy `secrets/exa.env.example` → `secrets/exa.env`, populate `EXA_API_KEY`.
2. Export the variable (`source secrets/exa.env` or add to your shell profile).
3. Run `scripts/check-mcp-exa.sh` to confirm connectivity.
4. Codex consumes the key via the `[mcp.exa]` block in `config/config.toml` or `config/config.json`.

## Operational Scripts

```bash
scripts/doctor.sh          # One-stop health check (git, config, prompts, MCP)
scripts/lint-config.sh     # Validates JSON/TOML and prompt index
scripts/check-prompts.sh   # Ensures index entries resolve to top-level markdown files
scripts/check-mcp-exa.sh   # Lightweight EXA MCP ping (requires EXA_API_KEY)
```

Integrate `scripts/doctor.sh` into your pre-flight routine before large edits.

## Configuration Files

- **config/config.toml** - Main configuration with profiles, project trust levels, and MCP settings
- **config/config.json** - Provider registry mirrored for Codex
- **AGENTS.md** - Core philosophy and design principles
- **prompts/** - Custom prompt library organized by category (see `prompts/index.json`)

## Philosophy

This configuration mirrors the Claude Code workflow system, bringing:

1. **Complexity Management** - Ousterhout principles baked into every workflow
2. **Quality Gates** - Automated validation before PR creation
3. **Workflow Orchestration** - Guided processes from spec to shipped feature
4. **Profile-Based Context** - Switch between deep thinking and fast execution

## Customization

### Adding New Prompts

Create markdown files in `prompts/`:

```markdown
---
name: my-prompt
description: What this prompt does
aliases: [short-name]
enabled: true
---

# My Custom Prompt

Prompt content here...
```

Access via `/prompts:my-prompt`

### Adding New Profiles

Edit `config/config.toml`:

```toml
[profiles.my-profile]
model = "gpt-5"
model_reasoning_effort = "medium"
approval_policy = "on-request"
sandbox_mode = "workspace-write"
```

Use via `codex --profile my-profile`

## Migration from Claude Code

| Claude Code | Codex CLI | Notes |
|-------------|-----------|-------|
| `/ultrathink` | `/prompts:ultrathink` | Same content |
| `/ship` | `/prompts:ship` | Workflow orchestration |
| `/execute` | `/prompts:execute` | Task execution |
| Skills | Review prompts | Converted to `/prompts:*` |
| Agents | `/prompts:*` (slash variants) | Simple top-level markdown commands |

## Resources

- [Codex CLI Docs](https://developers.openai.com/codex/cli)
- [Configuration Reference](https://developers.openai.com/codex/local-config)
- [Custom Prompts Guide](https://developers.openai.com/codex/cli/prompts)
