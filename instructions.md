## Baseline Notes (2025-11-04)
- Root configuration files moved under `config/` (track both TOML + JSON).
- Documentation lives in `docs/` with `CHANGELOG.md`.
- Prompt library catalog maintained via `prompts/index.json`.
- Slash commands centralized under `slash/` with manifest for discovery.
- Automation scripts reside in `scripts/` (`doctor`, `lint-config`, `check-slash`, `check-mcp-exa`).
- Secrets kept out of git under `secrets/` (copy `exa.env.example`).
