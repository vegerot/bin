#!/usr/bin/env bash
timeLeft.py || \
{ sleep 1; \
until out=$(timeLeft.py); do
	sleep 1;
done; }
echo $out;
exit 0
