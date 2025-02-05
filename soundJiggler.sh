#!/bin/bash

JiggleEvery=$(yad --scale --text="Jiggle every X seconds" --min-value=1 --max-value=60 --value=30 --title="" --center)

if [ $? -ne 0 ]; then
  echo "Exiting..."
  exit
fi

(
  while true; do
    paplay --volume=1 /usr/share/sounds/alsa/Front_Center.wav

    for ((i = 0; i < JiggleEvery; i++)); do
      echo $(( (i * 100) / JiggleEvery ))
      sleep 1
    done
  done
) | yad --progress --pulsate --auto-close --title="Sound Jiggling Every $JiggleEvery Seconds" --text="" --center --width=500 --button="Exit:0"
