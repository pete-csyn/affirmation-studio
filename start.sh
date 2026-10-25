#!/bin/sh
# Serves Affirmation Studio on localhost (the microphone needs a secure origin) and opens it.
cd "$(dirname "$0")" || exit 1
PORT=8765
python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER' INT TERM EXIT
sleep 1
open "http://localhost:$PORT/"
echo "Affirmation Studio running at http://localhost:$PORT/  (Ctrl+C to stop)"
wait $SERVER
