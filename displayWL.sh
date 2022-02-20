#!/bin/bash

FILE=$HOME/.local/share/ytwlcount
#icon=🎁
icon=⏩
nl=$(wc -l $FILE | cut -d ' ' -f 1)
echo $icon $nl
