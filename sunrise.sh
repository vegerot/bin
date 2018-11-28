#!/bin/bash
#curl -s $(/usr/local/bin/LocateMe -f "http://api.sunrise-sunset.org/json?lat={LAT}&lng={LON}") | python -c "import sys, json; print json.load(sys.stdin)['results']['sunrise']"
curl -s "http://api.sunrise-sunset.org/json?lat=39.38437152&lng=-76.5812774" | python3 -c "import sys, json; print(json.load(sys.stdin)['results']['sunrise'])"

