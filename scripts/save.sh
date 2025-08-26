#!/usr/bin/env bash

# Verifica argumento
if [ -z "$1" ]; then
    echo "Uso: save <nome_do_arquivo>"
    exit 1
fi

BASENAME="$1"

# Detecta clipboard backend
if command -v wl-paste &>/dev/null; then
    CLIP_GET_TEXT="wl-paste"
    CLIP_GET_IMAGE="wl-paste --type image/png"
elif command -v xclip &>/dev/null; then
    CLIP_GET_TEXT="xclip -selection clipboard -o"
    CLIP_GET_IMAGE="xclip -selection clipboard -t image/png -o"
else
    echo "[!] Nenhum gerenciador de clipboard encontrado (instale xclip ou wl-clipboard)."
    exit 1
fi

# 1) Testa imagem
if $CLIP_GET_IMAGE > "${BASENAME}.png" 2>/dev/null && [ -s "${BASENAME}.png" ]; then
    echo "[✔] Imagem salva como: ${BASENAME}.png"
    exit 0
else
    rm -f "${BASENAME}.png"
fi

# 2) Pega texto
TEXT="$($CLIP_GET_TEXT 2>/dev/null)"
if [ -z "$TEXT" ]; then
    echo "[!] Clipboard vazio."
    exit 1
fi

# 3) Se for JSON válido → salva como .json
if command -v jq &>/dev/null && echo "$TEXT" | jq empty 2>/dev/null; then
    echo "$TEXT" | jq '.' > "${BASENAME}.json"
    echo "[✔] JSON salvo como: ${BASENAME}.json"
else
    echo "$TEXT" > "${BASENAME}.txt"
    echo "[✔] Texto salvo como: ${BASENAME}.txt"
fi
