#!/usr/bin/env bash
set -euo pipefail

PORT="${1:-22}"

if command -v pkg >/dev/null 2>&1 && [ -n "${PREFIX:-}" ]; then
  SSHD_CONFIG="$PREFIX/etc/ssh/sshd_config"
  pkg install -y openssh
  sed -i -E "s/^#?Port .*/Port $PORT/" "$SSHD_CONFIG"
  grep -q "^Port " "$SSHD_CONFIG" || echo "Port $PORT" >> "$SSHD_CONFIG"
  pkill sshd 2>/dev/null || true
  sshd
  echo "Defina a senha do usuario atual ($(whoami)):"
  passwd
else
  SSHD_CONFIG=/etc/ssh/sshd_config
  sudo apt-get update
  sudo apt-get install -y openssh-server
  sudo sed -i -E "s/^#?Port .*/Port $PORT/" "$SSHD_CONFIG"
  grep -q "^Port " "$SSHD_CONFIG" || echo "Port $PORT" | sudo tee -a "$SSHD_CONFIG" > /dev/null
  sudo systemctl enable --now ssh
  sudo systemctl restart ssh
  echo "Defina a senha do usuario atual ($USER):"
  sudo passwd "$USER"
fi

IP=$(ip -4 addr show scope global 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -1)
[ -z "$IP" ] && IP=$(ifconfig 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '^127\.' | head -1)

echo "SSH server ativo na porta $PORT. IP: ${IP:-desconhecido}"
echo "Conectar com: ssh -p $PORT $(whoami)@${IP:-<ip>}"
