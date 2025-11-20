#!/usr/bin/env bash

set -e

# Google Fonts – Roboto (direto do repositório oficial)
BASE_URL="https://github.com/google/fonts/raw/main/apache/roboto"
FONT_ZIP="roboto.zip"
FONT_DIR="$HOME/.local/share/fonts/Roboto"

# Lista dos arquivos da família Roboto
FILES=(
  "Roboto-Regular.ttf"
  "Roboto-Bold.ttf"
  "Roboto-Italic.ttf"
  "Roboto-BoldItalic.ttf"
  "Roboto-Light.ttf"
  "Roboto-LightItalic.ttf"
  "Roboto-Medium.ttf"
  "Roboto-MediumItalic.ttf"
  "Roboto-Black.ttf"
  "Roboto-BlackItalic.ttf"
)

echo "Downloading Roboto font files..."
mkdir -p "$FONT_DIR"

# Criar um zip temporário com as fontes
rm -f "$FONT_ZIP"
mkdir -p tmp_roboto

for f in "${FILES[@]}"; do
    echo "Downloading $f..."
    curl -L "$BASE_URL/$f" -o "tmp_roboto/$f"
done

echo "Packaging downloaded files..."
cd tmp_roboto
zip -r "../$FONT_ZIP" . >/dev/null
cd ..

echo "Extracting..."
unzip -o "$FONT_ZIP" -d "$FONT_DIR" >/dev/null

echo "Refreshing font cache..."
fc-cache -f -v

echo "Cleaning up..."
rm -rf tmp_roboto "$FONT_ZIP"

echo "Roboto font installed successfully!"
