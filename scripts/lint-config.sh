#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

jq empty "$ROOT_DIR/config/config.json"

if command -v tomlq >/dev/null 2>&1; then
  tomlq -r '.' "$ROOT_DIR/config/config.toml" >/dev/null
else
  python3 - "$ROOT_DIR/config/config.toml" <<'PY'
import sys
import importlib
import importlib.util

path = sys.argv[1]
module = None
for name in ("tomllib", "tomli"):
    spec = importlib.util.find_spec(name)
    if spec is not None:
        module = importlib.import_module(name)
        break

if module is None:
    print("warning: toml validation skipped (tomllib/tomli unavailable)", file=sys.stderr)
    raise SystemExit(0)

with open(path, "rb") as fh:
    module.load(fh)
PY
fi

if [[ -f "$ROOT_DIR/prompts/index.json" ]]; then
  jq '.workflow, .quality, .review' "$ROOT_DIR/prompts/index.json" >/dev/null
fi

echo "configuration files validated"
