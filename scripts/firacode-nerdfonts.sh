#!/usr/bin/env bash

set -e

FONT_NAME="FiraCode"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
FONT_DIR="$HOME/.local/share/fonts"

echo "==> Creating font directory at $FONT_DIR ..."
mkdir -p "$FONT_DIR"

echo "==> Downloading FiraCode Nerd Font..."
curl -L "$DOWNLOAD_URL" -o /tmp/FiraCode.zip

echo "==> Unzipping..."
unzip -o /tmp/FiraCode.zip -d "$FONT_DIR"

echo "==> Cleaning up..."
rm /tmp/FiraCode.zip

echo "==> Updating font cache..."
fc-cache -fv

echo "==> FiraCode Nerd Font installed successfully!"
