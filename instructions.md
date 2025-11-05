## Baseline Notes (2025-11-04)
- Root configuration files moved under `config/` (track both TOML + JSON).
- Documentation lives in `docs/` with `CHANGELOG.md`.
- Prompt + slash catalog maintained via `prompts/index.json`.
- All prompt/slash markdown lives directly in `prompts/` so Codex discovers them without symlinks.
- Automation scripts reside in `scripts/` (`doctor`, `lint-config`, `check-prompts`, `check-mcp-exa`).
- Secrets kept out of git under `secrets/` (copy `exa.env.example`).
