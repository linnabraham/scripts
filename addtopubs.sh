#!/bin/bash

shdl "$1"

modfile="$(find   -type f  -printf "%T@ %Tc %p\n" | sort -nr | head -1 | awk '{print $8}')"
echo Downloaded file to $modfile
pubs add -D "$1" -d $modfile
