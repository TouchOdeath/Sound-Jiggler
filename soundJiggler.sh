#!/bin/bash

JiggleEvery=$(yad --form --field="Jiggle every (seconds):num" "60!1..300!1" --title="Sound Jiggler" --width=300 --center --button="OK:0" --button="Cancel:1" | cut -d'|' -f1)

if [ $? -ne 0 ]; then
  echo "Exiting..."
  exit
fi


if [ $? -eq 0 ]; then
	(
	  while true; do
		paplay --volume=1 /usr/share/sounds/alsa/Front_Center.wav

		for ((i = 0; i < JiggleEvery; i++)); do
		  echo $(( (i * 100) / JiggleEvery ))
		  sleep 1
		done
	  done
	) | yad --progress --pulsate --auto-close --title="Sound Jiggling Every $JiggleEvery Seconds" --center --width=500 --button="Exit:0"
fi
