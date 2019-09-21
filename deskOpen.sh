#!/usr/bin/env bash
`grep '^Exec' $1 | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g'` &

