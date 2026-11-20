#!/usr/bin/env bash
# migrate.sh — find and migrate yarn->pnpm and venv->uv projects
set -euo pipefail

SEARCH_ROOT="${1:-$HOME/develop}"

echo "=== Node.js (yarn -> pnpm) projects ==="
find "$SEARCH_ROOT" -name "package.json" -not -path "*/node_modules/*" 2>/dev/null | while read -r pkg; do
  dir=$(dirname "$pkg")
  if [ -f "$dir/yarn.lock" ]; then
    echo ">>> $dir"
    (
      cd "$dir"
      rm -rf node_modules
      rm -rf .next
      pnpm import
      pnpm install --dangerously-allow-all-builds
      rm pnpm-lock.yaml
      echo "    done: $dir"
    ) || echo "    FAILED: $dir"
  fi
done || true

echo "=== Python (venv -> uv) projects ==="
find "$SEARCH_ROOT" -name "requirements.txt" -not -path "*/.venv/*" -not -path "*/node_modules/*" 2>/dev/null | while read -r req; do
  dir=$(dirname "$req")
  if [ -d "$dir/.venv" ] || [ -d "$dir/venv" ]; then
    echo ">>> $dir"
    (
      cd "$dir"
      rm -rf .venv venv
      uv venv
      uv pip sync requirements.txt
      echo "    done: $dir"
    ) || echo "    FAILED: $dir"
  fi
done || true

echo "=== Summary of remaining old dirs ==="
find "$SEARCH_ROOT" -name "node_modules" -type d -prune -exec du -sh {} \; 2>/dev/null
find "$SEARCH_ROOT" \( -name ".venv" -o -name "venv" \) -type d -prune -exec du -sh {} \; 2>/dev/null
