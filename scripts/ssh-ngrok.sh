#!/usr/bin/env bash
# Install openssh-server and expose it via an ngrok TCP tunnel.
# Intended for Colab / ephemeral remote boxes.
#
# Usage:
#   NGROK_AUTHTOKEN=xxxx SSH_ROOT_PASSWORD=yyyy ./ssh_ngrok.sh
#
# Env vars:
#   NGROK_AUTHTOKEN     (required) ngrok authtoken
#   SSH_ROOT_PASSWORD   (required) password to set for the login user
#   SSH_USER        (optional) user to enable password login for (default: root)
#   NGROK_REGION    (optional) ngrok region (default: us)

set -euo pipefail

: "${NGROK_AUTHTOKEN:?set NGROK_AUTHTOKEN}"
: "${SSH_ROOT_PASSWORD:?set SSH_ROOT_PASSWORD}"
SSH_USER="${SSH_USER:-root}"
NGROK_REGION="${NGROK_REGION:-us}"
SSH_PORT="${SSH_PORT:-2222}"

SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

# --- install openssh-server ---
if ! command -v sshd >/dev/null 2>&1; then
  $SUDO apt-get update -qq
  $SUDO DEBIAN_FRONTEND=noninteractive apt-get install -y -qq openssh-server
fi

# --- install ngrok ---
if ! command -v ngrok >/dev/null 2>&1; then
  curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz \
    | $SUDO tar xz -C /usr/local/bin
fi

# --- configure sshd for password auth ---
$SUDO mkdir -p /var/run/sshd /run/sshd
$SUDO ssh-keygen -A                       # ensure host keys exist
# drop any conflicting Port / ListenAddress lines, then rewrite auth settings
$SUDO sed -i \
  -e '/^#\?Port /d' \
  -e '/^#\?ListenAddress /d' \
  -e 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' \
  -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' \
  -e 's/^#\?UsePAM.*/UsePAM no/' \
  /etc/ssh/sshd_config
printf '\nPort %s\nListenAddress 0.0.0.0\n' "$SSH_PORT" | $SUDO tee -a /etc/ssh/sshd_config >/dev/null

echo "${SSH_USER}:${SSH_ROOT_PASSWORD}" | $SUDO chpasswd

$SUDO pkill sshd 2>/dev/null || true
$SUDO /usr/sbin/sshd -e               # start daemon, log errors to stderr
$SUDO ss -tlnp 2>/dev/null | grep -q ":${SSH_PORT} " || { echo "sshd not listening on :${SSH_PORT}" >&2; exit 1; }

# --- start ngrok tunnel ---
ngrok config add-authtoken "$NGROK_AUTHTOKEN"
pkill -x ngrok 2>/dev/null || true
nohup ngrok tcp "$SSH_PORT" --region "$NGROK_REGION" --log stdout > /tmp/ngrok.log 2>&1 &

# --- print connection string ---
for _ in $(seq 1 20); do
  url=$(curl -s http://127.0.0.1:4040/api/tunnels \
    | grep -oE 'tcp://[0-9a-z.-]+:[0-9]+' | head -1 || true)
  [ -n "$url" ] && break
  sleep 1
done

if [ -z "${url:-}" ]; then
  echo "ngrok tunnel not up; check /tmp/ngrok.log" >&2
  exit 1
fi

host=$(echo "$url" | sed 's#tcp://##; s#:.*##')
port=$(echo "$url" | sed 's#.*:##')
echo
echo "SSH ready:"
echo "  ssh ${SSH_USER}@${host} -p ${port}"
echo "  password: ${SSH_ROOT_PASSWORD}"
echo "export SSH_MCP_HOST=\"${host}\""
echo "export SSH_MCP_PORT=\"${port}\""
