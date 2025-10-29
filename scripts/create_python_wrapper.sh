#!/bin/zsh
# Script para criar um wrapper executável para um script Python em um venv
# Uso: ./create_python_wrapper.sh

set -e

WRAPPER_DIR="$HOME/bin"

mkdir -p "$WRAPPER_DIR"

echo "== Gerador de wrapper para script Python em venv =="
echo "Informe o caminho COMPLETO do script Python que deseja tornar global:"
read -r SCRIPT_PATH
if [[ -z "$SCRIPT_PATH" ]]; then
    echo "Caminho do script não informado. Saindo."
    exit 1
fi
if [[ ! -f "$SCRIPT_PATH" ]]; then
    echo "Arquivo não encontrado: $SCRIPT_PATH"
    exit 1
fi

SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

# Verifica se existe venv ou .venv no mesmo diretório do script
if [[ -f "$SCRIPT_DIR/venv/bin/activate" ]]; then
    VENV_DIR="$SCRIPT_DIR/venv"
    echo "Venv encontrado em: $VENV_DIR"
elif [[ -f "$SCRIPT_DIR/.venv/bin/activate" ]]; then
    VENV_DIR="$SCRIPT_DIR/.venv"
    echo "Venv encontrado em: $VENV_DIR"
else
    echo "Não foi encontrado venv no diretório do script. Informe o caminho COMPLETO do diretório do venv (onde está o bin/activate) [pressione Enter para ignorar]:"
    read -r VENV_DIR
    if [[ -z "$VENV_DIR" ]]; then
        echo "Wrapper será criado sem ativar venv."
        VENV_DIR=""
    elif [[ ! -f "$VENV_DIR/bin/activate" ]]; then
        echo "Venv inválido: $VENV_DIR"
        exit 1
    fi
fi


SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
WRAPPER_PATH="$WRAPPER_DIR/$SCRIPT_NAME"
if [[ -n "$VENV_DIR" ]]; then
    cat > "$WRAPPER_PATH" <<EOF
#!/bin/zsh
source "$VENV_DIR/bin/activate"
python "$SCRIPT_PATH" "\$@"
EOF
else
    cat > "$WRAPPER_PATH" <<EOF
#!/bin/zsh
python3 "$SCRIPT_PATH" "\$@"
EOF
fi
chmod +x "$WRAPPER_PATH"
echo "Wrapper criado: $WRAPPER_PATH"
echo "Agora você pode rodar '$SCRIPT_NAME' de qualquer lugar."
