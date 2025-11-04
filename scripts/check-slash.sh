#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST="$ROOT_DIR/slash/manifest.json"

if [[ ! -f "$MANIFEST" ]]; then
  echo "slash manifest missing at $MANIFEST" >&2
  exit 1
fi

jq '.commands | length' "$MANIFEST" >/dev/null

while IFS= read -r path; do
  if [[ ! -f "$ROOT_DIR/$path" ]]; then
    echo "registered slash command missing file: $path" >&2
    exit 1
  fi

  if ! awk 'NR==1 {exit !(match($0, /^---$/))}' "$ROOT_DIR/$path"; then
    echo "slash command $path missing front matter" >&2
    exit 1
  fi

done < <(jq -r '.commands[] | select(.enabled != false) | .path' "$MANIFEST")

echo "slash commands validated"
