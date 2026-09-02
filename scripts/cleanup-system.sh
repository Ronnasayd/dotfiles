#!/usr/bin/env bash
# Libera espaco no root (/). Causa principal neste sistema: Docker build cache + imagens
# sem container. Tambem limpa apt, journald, snap, caches de usuario, kernels velhos.
#
# NAO remove: imagens Docker com container, volumes Docker, kernel em uso, configs.
# Modo padrao = seguro (so lixo re-geravel). Use --aggressive pra imagens sem container.
#
#   ./cleanup-system.sh              # seguro
#   ./cleanup-system.sh --aggressive # + imagens/volumes orfaos Docker (re-pull depois)
#   ./cleanup-system.sh --dry-run    # so mostra, nao apaga
set -uo pipefail

AGGRESSIVE=0
DRY=0
for a in "$@"; do
  case "$a" in
    --aggressive) AGGRESSIVE=1 ;;
    --dry-run)    DRY=1 ;;
    -h|--help)    grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "flag desconhecida: $a"; exit 1 ;;
  esac
done

SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

run() {
  if [ "$DRY" -eq 1 ]; then
    echo "  [dry] $*"
  else
    eval "$@" 2>/dev/null || true
  fi
}

used_root() { df -BM --output=used / | tail -1 | tr -dc '0-9'; }

before=$(used_root)
echo "=== root usado antes: $((before)) MB ==="
echo

# ---------------------------------------------------------------------------
echo "[1/8] APT: cache de pacotes + pacotes orfaos"
run "$SUDO apt-get clean"
run "$SUDO apt-get autoclean -y"
run "$SUDO apt-get autoremove --purge -y"

# ---------------------------------------------------------------------------
echo "[2/8] Kernels antigos (mantem o atual + 1 anterior)"
CUR=$(uname -r)
if command -v dpkg >/dev/null; then
  OLD=$(dpkg -l 'linux-image-[0-9]*' 2>/dev/null | awk '/^ii/{print $2}' \
        | grep -v "$CUR" | head -n -1)
  [ -n "$OLD" ] && run "$SUDO apt-get purge -y $OLD" || echo "  nada a remover"
fi

# ---------------------------------------------------------------------------
echo "[3/8] journald: limita log a 200M / 14 dias"
run "$SUDO journalctl --vacuum-size=200M"
run "$SUDO journalctl --vacuum-time=14d"

# ---------------------------------------------------------------------------
echo "[4/8] Snap: revisoes desativadas"
if command -v snap >/dev/null; then
  snap list --all 2>/dev/null | awk '/disabled/{print $1, $3}' | while read -r name rev; do
    run "$SUDO snap remove '$name' --revision='$rev'"
  done
  run "$SUDO sh -c 'snap set system refresh.retain=2'"
else
  echo "  snap nao instalado"
fi

# ---------------------------------------------------------------------------
echo "[5/8] Flatpak: runtimes nao usados"
if command -v flatpak >/dev/null; then
  run "flatpak uninstall --unused -y"
else
  echo "  flatpak nao instalado"
fi

# ---------------------------------------------------------------------------
echo "[6/8] Docker: build cache (7.5G aqui) + imagens dangling"
if command -v docker >/dev/null && docker info >/dev/null 2>&1; then
  run "docker builder prune -af"
  run "docker image prune -f"           # so <none>
  run "docker container prune -f"       # so parados
  run "docker network prune -f"
  if [ "$AGGRESSIVE" -eq 1 ]; then
    echo "  --aggressive: imagens sem container + volumes orfaos"
    run "docker image prune -af"        # tudo que nao tem container rodando
    run "docker volume prune -f"        # volumes sem link (CUIDADO: dados de DB parados)
  fi
else
  echo "  docker nao ativo"
fi

# ---------------------------------------------------------------------------
echo "[7/8] Caches de usuario re-geraveis"
run "rm -rf $HOME/.cache/thumbnails/*"
run "rm -rf $HOME/.cache/pip/*"
run "rm -rf $HOME/.cache/yarn/*"
run "rm -rf $HOME/.cache/go-build/*"
run "rm -rf $HOME/.cache/ms-playwright/*"
run "rm -rf $HOME/.cache/puppeteer/*"
run "rm -rf $HOME/.local/share/Trash/*"
command -v npm  >/dev/null && run "npm cache clean --force"
command -v go   >/dev/null && run "go clean -cache -modcache -testcache"
command -v uv   >/dev/null && run "uv cache prune"
command -v pnpm >/dev/null && run "pnpm store prune"

# ---------------------------------------------------------------------------
echo "[8/8] Coredumps + tmp velho"
run "$SUDO rm -rf /var/lib/systemd/coredump/*"
run "$SUDO find /tmp -mindepth 1 -mtime +7 -delete"
run "$SUDO find /var/tmp -mindepth 1 -mtime +14 -delete"

# ---------------------------------------------------------------------------
echo
after=$(used_root)
echo "=== root usado depois: $((after)) MB ==="
if [ "$DRY" -eq 0 ]; then
  echo "=== liberado: $((before - after)) MB ==="
fi
echo
df -h /
