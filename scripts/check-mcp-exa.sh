#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${EXA_API_KEY:-}" ]]; then
  echo "EXA_API_KEY environment variable is not set" >&2
  exit 1
fi

status="$(curl --silent --output /dev/null --write-out '%{http_code}' \
  -H "x-api-key: $EXA_API_KEY" \
  "https://api.exa.ai/v1/search")"

case "$status" in
  401)
    echo "EXA API key rejected (401)" >&2
    exit 1
    ;;
  000)
    echo "Failed to reach EXA endpoint" >&2
    exit 1
    ;;
esac

echo "EXA MCP endpoint reachable (HTTP $status)"
