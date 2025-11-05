#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INDEX="$ROOT_DIR/prompts/index.json"

if [[ ! -f "$INDEX" ]]; then
  echo "prompt index missing at $INDEX" >&2
  exit 1
fi

jq '.prompts | length' "$INDEX" >/dev/null
jq '(.slash // []) | length' "$INDEX" >/dev/null

jq -r '.prompts[]?.path, (.slash[]?.path // empty)' "$INDEX" | while IFS= read -r rel_path; do
  file="$ROOT_DIR/$rel_path"
  if [[ -z "$rel_path" ]]; then
    continue
  fi
  if [[ ! -f "$file" ]]; then
    echo "missing prompt file: $rel_path" >&2
    exit 1
  fi
  if ! awk 'NR==1 {exit !(match($0, /^---$/))}' "$file"; then
    echo "prompt $rel_path missing front matter" >&2
    exit 1
  fi
  if ! awk 'NR==2 {exit !(match($0, /name:/))}' "$file"; then
    echo "prompt $rel_path missing name declaration" >&2
    exit 1
  fi
 done

echo "prompts and slash commands validated"
