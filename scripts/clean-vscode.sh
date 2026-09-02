#!/usr/bin/env bash
# Limpa caches do VS Code. Nao toca: settings.json, keybindings.json, extensoes ativas,
# login GitHub/Copilot (globalStorage + keychain do SO), sync.
# Perda: histatico de chat Copilot antigo, .vsix baixados (re-baixam), logs, versoes
# velhas de extensao ja desinstaladas.
set -euo pipefail

C="$HOME/.config/Code"
V="$HOME/.vscode"

if pgrep -x code >/dev/null; then
  echo "VS Code esta rodando. Feche antes de rodar. Abortado."
  exit 1
fi

paths=(
  "$C/CachedExtensionVSIXs"          # 804M - .vsix baixados
  "$C/CachedProfilesData"
  "$C/Cache" "$C/CachedData" "$C/GPUCache" "$C/Code Cache"
  "$C/logs" "$C/Crashpad"
  "$C/Partitions/vscode-browser"     # cache Simple Browser
  "$C/DawnWebGPUCache" "$C/DawnGraphiteCache"
)

before=$(du -sc "$C" "$V/extensions" 2>/dev/null | tail -1 | cut -f1)

for p in "${paths[@]}"; do rm -rf "$p" 2>/dev/null || true; done

# WebStorage: localStorage de webviews (Copilot chat UI etc), regenera
rm -rf "$C"/WebStorage/* 2>/dev/null || true

# chat Copilot antigo por workspace
find "$C/User/workspaceStorage" -mindepth 2 -maxdepth 2 -type d \
  \( -name chatSessions -o -name chatEditingSessions -o -name "GitHub.copilot-chat" \) \
  -exec rm -rf {} + 2>/dev/null || true

# backups velhos de keybindings
rm -f "$C"/User/keybindings.json.*.bak "$C"/User/keybindings.json.backup.* 2>/dev/null || true

# versoes desinstaladas de extensao listadas em .obsolete
OBS="$V/extensions/.obsolete"
if [ -f "$OBS" ]; then
  grep -oE '"[^"]+":true' "$OBS" | sed 's/":true//;s/^"//' | while read -r dir; do
    [ -n "$dir" ] && rm -rf "$V/extensions/$dir" 2>/dev/null || true
  done
  echo '{}' > "$OBS"
fi

after=$(du -sc "$C" "$V/extensions" 2>/dev/null | tail -1 | cut -f1)
echo "antes:    $((before/1024)) MB"
echo "depois:   $((after/1024)) MB"
echo "liberado: $(((before-after)/1024)) MB"
