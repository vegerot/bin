#!/usr/bin/env bash
~/bin/timeLeft.py
until [ $? == 0 ]; do
	~/bin/timeLeft.py;
	sleep 1; 
done
