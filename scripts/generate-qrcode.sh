#!/bin/bash
if [ $# -eq 0 ]; then
    exit 0
elif [ $# -eq 1 ]; then
    URL=$1
else
    PARAM=$1
    URL=$2
fi
if [ "$PARAM" == "-w" ]; then
    URL="https://api.whatsapp.com/send/?text=$URL"
fi
qrencode -o /tmp/qrencode.png "$URL" && display /tmp/qrencode.png
