#!/bin/bash
REF=$1
INO=$(stat -c %i $REF)
HASH=$(echo -n "$REF$INO" | md5sum | awk '{ print $1 }')
cp ~/.config/Code/User/workspaceStorage/$HASH/state.vscdb /tmp/state.vscdb
echo "/home/ronnas/.config/Code/User/workspaceStorage/$HASH/state.vscdb"