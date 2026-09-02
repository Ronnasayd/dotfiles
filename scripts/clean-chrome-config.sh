#!/usr/bin/env bash
# Limpa caches do Chrome em ~/.config/google-chrome (bloqueados pelo hook do projeto).
# Nao toca: Cookies, Local Storage, Login Data, IndexedDB, Extensions, bookmarks.
# Perda: assets de PWA re-baixam, instaladores de extensao re-baixam. Zero login perdido.
set -euo pipefail

CFG="$HOME/.config/google-chrome"

if pgrep -x chrome >/dev/null; then
  echo "Chrome esta rodando. Feche antes de rodar. Abortado."
  exit 1
fi

[ -d "$CFG" ] || { echo "$CFG nao existe. Abortado."; exit 1; }

before=$(du -sc "$CFG" 2>/dev/null | tail -1 | cut -f1)

# Service Worker CacheStorage por profile (~1.2G)
find "$CFG" -mindepth 3 -maxdepth 3 -type d -path "*/Service Worker/CacheStorage" -exec rm -rf {} + 2>/dev/null || true

# Caches de instaladores de extensao (~277M)
rm -rf "$CFG/component_crx_cache" "$CFG/extensions_crx_cache" 2>/dev/null || true

# Crash reports (~27M)
rm -rf "$CFG/Crash Reports" 2>/dev/null || true

# GPUCache por profile (regenera)
find "$CFG" -mindepth 2 -maxdepth 2 -type d -name GPUCache -exec rm -rf {} + 2>/dev/null || true

after=$(du -sc "$CFG" 2>/dev/null | tail -1 | cut -f1)
echo "antes:    $((before/1024)) MB"
echo "depois:   $((after/1024)) MB"
echo "liberado: $(((before-after)/1024)) MB"
