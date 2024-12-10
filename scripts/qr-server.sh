#!/bin/bash
if [ $# -eq 0 ]; then
    DIR=$(pwd)
else
    DIR=$1
fi
echo "servinfg files from: $DIR"
SERVER_PORT=8000
python3 -m http.server -d $DIR $SERVER_PORT >/dev/null & 
SERVER_PID=$!
ngrok http $SERVER_PORT >/dev/null &
TUNNEL_PID=$!
sleep 5
URL="$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r .tunnels[0].public_url)"
echo "$URL"
qrencode -o /tmp/qrencode.png "$URL" 
display /tmp/qrencode.png
kill $SERVER_PID
kill $TUNNEL_PID
