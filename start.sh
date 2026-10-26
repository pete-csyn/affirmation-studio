#!/bin/sh
# Serves Affirmation Studio on localhost (the microphone needs a secure origin) and opens it.
# Prefers port 8765: saved takes belong to the exact address, so a different port shows an empty list.
cd "$(dirname "$0")" || exit 1
PORT=8765
while lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; do PORT=$((PORT + 1)); done
python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER 2>/dev/null' INT TERM EXIT
sleep 1
open "http://localhost:$PORT/"
echo "Affirmation Studio running at http://localhost:$PORT/  (Ctrl+C to stop)"
[ "$PORT" != 8765 ] && echo "Port 8765 is busy, so takes saved at localhost:8765 won't appear here until it frees up."
wait $SERVER
