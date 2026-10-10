#!/usr/bin/env bash
set -euo pipefail

PORT="${1:-2222}"

if command -v pkg >/dev/null 2>&1 && [ -n "${PREFIX:-}" ]; then
  SSHD_CONFIG="$PREFIX/etc/ssh/sshd_config"
  pkg install -y openssh
  sed -i -E "s/^#?Port .*/Port $PORT/" "$SSHD_CONFIG"
  grep -q "^Port " "$SSHD_CONFIG" || echo "Port $PORT" >> "$SSHD_CONFIG"
  pkill sshd 2>/dev/null || true
  sshd
  echo "Defina a senha do usuario atual ($(whoami)):"
  passwd
elif [ -d /run/systemd/system ]; then
  SSHD_CONFIG=/etc/ssh/sshd_config
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server
  sudo sed -i -E "s/^#?Port .*/Port $PORT/" "$SSHD_CONFIG"
  grep -q "^Port " "$SSHD_CONFIG" || echo "Port $PORT" | sudo tee -a "$SSHD_CONFIG" > /dev/null
  sudo systemctl enable --now ssh
  sudo systemctl restart ssh
  echo "Defina a senha do usuario atual ($USER):"
  sudo passwd "$USER"
else
  # Sem systemd (proot-distro, container, chroot): inicia sshd direto
  SSHD_CONFIG=/etc/ssh/sshd_config
  SUDO=""
  command -v sudo >/dev/null 2>&1 && [ "$(id -u)" -ne 0 ] && SUDO="sudo"
  $SUDO apt-get update
  $SUDO env DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server
  $SUDO ssh-keygen -A
  $SUDO mkdir -p /run/sshd
  $SUDO sed -i -E "s/^#?Port .*/Port $PORT/" "$SSHD_CONFIG"
  grep -q "^Port " "$SSHD_CONFIG" || echo "Port $PORT" | $SUDO tee -a "$SSHD_CONFIG" > /dev/null
  $SUDO sed -i -E "s/^#?PermitRootLogin .*/PermitRootLogin yes/" "$SSHD_CONFIG"
  pkill sshd 2>/dev/null || true
  $SUDO /usr/sbin/sshd
  echo "Defina a senha do usuario atual ($USER):"
  $SUDO passwd "$USER"
fi

IP=$(ip -4 addr show scope global 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | tail -1) || true
if [ -z "$IP" ]; then
  IP=$(ifconfig 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '^127\.' | tail -1) || true
fi

echo "SSH server ativo na porta $PORT. IP: ${IP:-desconhecido}"
echo "Conectar com: ssh -p $PORT $(whoami)@${IP:-<ip>}"
