#!/usr/bin/env bash


checkOut ()
{
    prev=""
    while read -r data; do
        #echo $data
        if [[ $data != $prev ]]; then
            echo $data
        fi
        prev=$data
    done
}

#sudo fs_usage -w -f filesys backupd | grep HFS_update --color=always|awk '{ for(i=4; i<=9; ++i) printf "%s ",  $i; print "" }'|xargs -n1 checkOut

sudo fs_usage -w -f filesys backupd | grep HFS_update --color=always|awk '{ for(i=4; i<=8; ++i) printf "%s ",  $i; print "" }'|checkOut
