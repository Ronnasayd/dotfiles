#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Execute este script como root."
    exit 1
fi

if [ -z "$1" ]; then
    echo "Uso: $0 <usuario>"
    exit 1
fi

USERNAME="$1"
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"

# Verifica se o usuário já existe
if id "$USERNAME" &>/dev/null; then
    echo "Usuário '$USERNAME' já existe."
else
    echo "Criando usuário '$USERNAME'..."
    adduser "$USERNAME"
fi

# Garante que o sudo esteja instalado
if ! command -v sudo &>/dev/null; then
    echo "sudo não está instalado."
    echo "Instale com: apt update && apt install sudo"
    exit 1
fi

# Cria configuração individual do sudo
echo "Configurando sudo para '$USERNAME'..."

cat > "$SUDOERS_FILE" <<EOF
$USERNAME ALL=(ALL:ALL) ALL
EOF

# Permissão obrigatória para arquivos sudoers
chmod 440 "$SUDOERS_FILE"

# Valida configuração
if visudo -cf "$SUDOERS_FILE"; then
    echo
    echo "Usuário '$USERNAME' configurado com sucesso."
    echo
    echo "Teste com:"
    echo "  su - $USERNAME"
    echo "  sudo whoami"
else
    echo "ERRO: configuração do sudoers inválida."
    rm -f "$SUDOERS_FILE"
    exit 1
fi




# Install libs
sudo apt update

sudo apt install -y \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libncursesw5-dev \
  xz-utils \
  tk-dev \
  libxml2-dev \
  libxmlsec1-dev \
  libffi-dev \
  liblzma-dev \
  uuid-dev

#  Install asdf
ASDF_VERSION=0.18.0
curl -LO "https://github.com/asdf-vm/asdf/releases/download/v${ASDF_VERSION}/asdf-v${ASDF_VERSION}-linux-arm64.tar.gz"

tar -xzf asdf-v${ASDF_VERSION}-linux-arm64.tar.gz

sudo install -m 755 asdf /usr/local/bin/asdf

apt install -y python3-pip
