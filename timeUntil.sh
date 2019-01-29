#!/usr/bin/env bash
~/bin/timeLeft.py
until [[ $prev == 0 ]]; do
	~/bin/timeLeft.py;
	prev=$?;
    sleep 1; 
done
