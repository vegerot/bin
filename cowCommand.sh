#!/usr/bin/env bash
IFS=$(echo -en ":")
while : ; do

    output="$(whatis `ls $PATH| sort -R|head -1`)" && break
	
done
echo $output|cowsay -f $(cowsay -l| tail -n+2|tr " " "\n"|sort -R|head -1)|lolcat
