#!/usr/bin/env bash
# Usage: urls-to-strm.sh <list.txt> [out_dir]
# One URL per line -> 01.strm, 02.strm, ... in out_dir (default: list's dir).
set -euo pipefail

list="${1:?usage: $0 <list.txt> [out_dir]}"
out="${2:-$(dirname "$list")}"
mkdir -p "$out"

n=0
while IFS= read -r url || [[ -n "$url" ]]; do
  url="${url%$'\r'}"
  [[ -z "${url// }" || "$url" == \#* ]] && continue
  n=$((n + 1))
  printf '%s\n' "$url" >"$out/$(printf '%02d' "$n").strm"
done <"$list"

echo "$n .strm files -> $out"
