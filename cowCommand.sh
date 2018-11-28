#!/bin/bash

while : ; do
	output="$(whatis `ls -1 $(echo $PATH|tr ":" " ")| sort -R|head -1`)"
	[[ $output == *"nothing"* ]] || break
done
cowsay -f $( cowsay -l| tail -n+2|tr " " "\n"|sort -R|head -1) "$output"
