#!/bin/bash
FILEPATH=$(xclip -o -selection clipboard)
BASENAME=$(basename $FILEPATH)
DIR=$(dirname $FILEPATH)
echo "servinfg files from: $DIR/$BASENAME"
SERVER_PORT=8965
python3 -m http.server -d $DIR $SERVER_PORT > /dev/null &
SERVER_PID=$!
/usr/local/bin/ngrok http $SERVER_PORT > /dev/null &
TUNNEL_PID=$!
sleep 2
URL="$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r .tunnels[0].public_url)"
echo "$URL"
qrencode -o /tmp/qrencode.png "$URL/$BASENAME"
display /tmp/qrencode.png
kill $SERVER_PID
kill $TUNNEL_PID
