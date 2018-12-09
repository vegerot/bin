#!/usr/bin/env python3

import subprocess
import re
import os

def main():
    #print(os.environ['SHELL'])
    out=subprocess.check_output("sudo bash -c \"echo exit|dtruss bash -li|& less|grep '^open'\"",shell=True).decode('utf-8')
    p=re.compile(r'open\(\"(?P<file>.*)\\0\".*\n')
    files=p.findall(out)
    #print(files)
    #[print(f) for f in files]
    #Unique in-order elements
    [print(f) for f in unique_elements(files)]


def unique_elements(iterable):
    seen=set()
    result=[]
    for element in iterable:
        hashed=element
        if isinstance(element,dict):
            hashed=tuple(sorted(element.iteritmes()))
        elif isinstance(element, list):
           hashed=tuple(element)
        if hashed not in seen:
            result.append(element)
            seen.add(hashed)
    return result


if __name__=="__main__":
    main()
