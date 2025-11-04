#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${EXA_API_KEY:-}" ]]; then
  echo "EXA_API_KEY environment variable is not set" >&2
  exit 1
fi

curl --silent --fail --head \
  --header "x-api-key: $EXA_API_KEY" \
  "https://api.exa.ai/v1/search" >/dev/null

echo "EXA MCP endpoint reachable"
