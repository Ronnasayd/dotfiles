#!/usr/bin/env bash

set -e

# Nerd Fonts official download (latest JetBrains Mono)
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
FONT_ZIP="JetBrainsMonoNerdFont.zip"
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNF"

echo "Downloading JetBrains Mono Nerd Font..."
mkdir -p "$FONT_DIR"
curl -L "$FONT_URL" -o "$FONT_ZIP"

echo "Extracting..."
unzip -o "$FONT_ZIP" -d "$FONT_DIR"

echo "Refreshing font cache..."
fc-cache -f -v

echo "Cleaning up..."
rm "$FONT_ZIP"

echo "JetBrains Mono Nerd Font installed successfully!"
