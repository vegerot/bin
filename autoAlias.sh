#!/bin/bash

for filename in ~/bin/*.py; do
	alias $(basename -s ".py" $filename)="$filename"
done
for filename in ~/bin/*.sh; do
	alias $(basename -s ".sh" $filename)="$filename"
done

