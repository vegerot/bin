#!/usr/bin/env bash
IFS=":"
output="$(whatis `ls $PATH | sort -R | head -1`)"
echo "$output" | cowsay -f $(cowsay -l | tail -n+2 | tr " " "\n" | sort -R | head -1) | lolcat
