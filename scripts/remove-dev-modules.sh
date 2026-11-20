#!/usr/bin/env bash
# migrate.sh — find and migrate yarn->pnpm and venv->uv projects
set -euo pipefail

SEARCH_ROOT="${1:-$HOME/develop}"

echo "=== Node.js projects ==="
find "$SEARCH_ROOT" -name "package.json" -not -path "*/node_modules/*" 2>/dev/null | while read -r pkg; do
  dir=$(dirname "$pkg")
  echo ">>> $dir"
  (
    cd "$dir"
    rm -rf node_modules
    rm -rf .next
    echo "    done: $dir"
  ) || echo "    FAILED: $dir"
done || true

echo "=== Python  projects ==="
find "$SEARCH_ROOT" \( -name "requirements.txt" -o -name "pyproject.toml" \) -not -path "*/.venv/*" -not -path "*/node_modules/*" 2>/dev/null | while read -r req; do
  dir=$(dirname "$req")
  echo ">>> $dir"
  (
    cd "$dir"
    rm -rf .venv venv
    echo "    done: $dir"
  ) || echo "    FAILED: $dir"
done || true

echo "=== Summary of remaining old dirs ==="
find "$SEARCH_ROOT" -name "node_modules" -type d -prune -exec du -sh {} \; 2>/dev/null
find "$SEARCH_ROOT" \( -name ".venv" -o -name "venv" \) -type d -prune -exec du -sh {} \; 2>/dev/null
