#!/usr/bin/env bash
timeLeft.py
prev=$?;
until [[ $prev == 0 ]]; do
	sleep 1;
	out=$(timeLeft.py);
	prev=$?; 
done
echo $out;
exit 0
