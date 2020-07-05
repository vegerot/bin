#!/usr/bin/env bash
IFS=":"
whatis $(find $PATH | sort -R | head -1) | \
cowsay -f $(cowsay -l | tail -n+2 | tr " " "\n" | sort -R | head -1) | \
lolcat
