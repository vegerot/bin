#!/usr/bin/env bash
~/bin/timeLeft.py
prev=$?;
until [[ $prev == 0 ]]; do
    out=$(~/bin/timeLeft.py);
	prev=$?;
    sleep 1; 
done
echo $out;
exit 0
