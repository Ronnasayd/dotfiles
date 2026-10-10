#!/usr/bin/env bash
set -euo pipefail

ANDROID_VERSION="${1:-11.0.0}"
DOCKERHUB_USER="${2:-ronnasayd}"
IMAGE_NAME="redroid"
WORKDIR="$(mktemp -d)"

cleanup() { rm -rf "$WORKDIR"; }
trap cleanup EXIT

echo "Clonando redroid-script em $WORKDIR..."
git clone --depth 1 https://github.com/abing7k/redroid-script "$WORKDIR"
cd "$WORKDIR"

echo "Buildando imagem redroid:$ANDROID_VERSION com gapps..."
sudo python3 redroid.py -a "$ANDROID_VERSION" -g

LOCAL_TAG="$IMAGE_NAME/$IMAGE_NAME:${ANDROID_VERSION}_gapps"
REMOTE_TAG="$DOCKERHUB_USER/$IMAGE_NAME:${ANDROID_VERSION}_gapps"

echo "Tag: $LOCAL_TAG -> $REMOTE_TAG"
docker tag "$LOCAL_TAG" "$REMOTE_TAG"

echo "Push: $REMOTE_TAG"
docker push "$REMOTE_TAG"

echo "Pronto: $REMOTE_TAG"
