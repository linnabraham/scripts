#!/bin/bash

icon=🔖

num="$(buku -p -f 1 | wc -l)"
echo $icon $num
