#!/bin/sh
if timeLeft.py; then
	echo
else
	sleep 1;
	until out="$(timeLeft.py)"; do
		sleep 1
	done
	echo "$out"
fi
