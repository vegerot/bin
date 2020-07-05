#!/usr/bin/env bash

javac "$1" && java "${1%.java}"
