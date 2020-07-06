#!/usr/bin/env bash
timeLeft.py
until [ $? == 0 ]; do
	sleep 1;
	out=$(timeLeft.py);
done
echo $out;
exit 0
