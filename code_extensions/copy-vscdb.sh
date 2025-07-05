#!/bin/bash
REF=$1
INO=$(stat -c %i $REF)
HASH=$(echo -n "$REF$INO" | md5sum | awk '{ print $1 }')
if [ -f "/home/ronnas/.config/Code/User/workspaceStorage/$HASH/state.vscdb" ]; then
  cp ~/.config/Code/User/workspaceStorage/$HASH/state.vscdb /tmp/state.vscdb
else
  mkdir -p /home/ronnas/.config/Code/User/workspaceStorage/$HASH
  cp ~/develop/personal/dotfiles/code_extensions/state.vscdb /tmp/state.vscdb
  cp ~/develop/personal/dotfiles/code_extensions/state.vscdb /home/ronnas/.config/Code/User/workspaceStorage/$HASH/state.vscdb
fi
echo "/home/ronnas/.config/Code/User/workspaceStorage/$HASH/state.vscdb"
