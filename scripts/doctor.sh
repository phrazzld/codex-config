#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

function section() {
  printf '\n[%s]\n' "$1"
}

section "Git"
if git -C "$ROOT_DIR" diff --quiet --ignore-submodules HEAD; then
  echo "clean"
else
  echo "dirty"
  git -C "$ROOT_DIR" status --short
fi

section "Config"
"$ROOT_DIR/scripts/lint-config.sh"

section "Prompts"
"$ROOT_DIR/scripts/check-prompts.sh"

section "MCP"
if [[ -z "${EXA_API_KEY:-}" ]]; then
  echo "EXA_API_KEY not exported; skip connectivity"
else
  "$ROOT_DIR/scripts/check-mcp-exa.sh"
fi

section "Summary"
echo "doctor completed"
