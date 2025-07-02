#!/bin/bash
FILEPATH=$(xclip -o -selection clipboard)
BASENAME=$(basename "${FILEPATH}")
URLBASENAME=$(echo "$BASENAME" | sed 's/\\ /%20/g')
DIR=$(dirname "${FILEPATH}")
echo "serving files from: $DIR/$BASENAME"
SERVER_PORT=8968
python3 -m http.server -d "$DIR" $SERVER_PORT > /dev/null &
SERVER_PID=$!
/usr/local/bin/ngrok http $SERVER_PORT > /dev/null &
TUNNEL_PID=$!
sleep 2
URL="$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')"
echo "$URL/$URLBASENAME"
qrencode -o /tmp/qrencode.png "$URL/$URLBASENAME"
display /tmp/qrencode.png
kill $SERVER_PID
kill $TUNNEL_PID
