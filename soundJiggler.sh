#!/bin/bash

cleanup() {
  pkill -P $$ 2>/dev/null
  exit 0
}

trap cleanup EXIT SIGINT SIGTERM

JiggleEvery=$(yad --form --field="Jiggle every (seconds):num" "60!1..300!1" --title="Sound Jiggler" --width=300 --center --button="OK:0" --button="Cancel:1" --on-top)

if [ $? -ne 0 ] || [ -z "$JiggleEvery" ]; then
  cleanup
fi

JiggleEvery=$(echo "$JiggleEvery" | cut -d'|' -f1)

if ! [[ "$JiggleEvery" =~ ^[0-9]+$ ]]; then
  echo "Invalid input. Exiting..."
  cleanup
fi

(
  while true; do
    paplay --volume=1 /usr/share/sounds/alsa/Front_Center.wav
    for ((i = 0; i < JiggleEvery; i++)); do
      echo $(( (i * 100) / JiggleEvery ))
      sleep 1
    done
  done
) | yad --progress --pulsate --auto-close --title="Sound Jiggling Every $JiggleEvery Seconds" --width=500 --center --button="Exit:0" --on-top &

YAD_PID=$!

wait $YAD_PID

cleanup
