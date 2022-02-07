#!/bin/bash
# script that writes tasks with deadline to a textfile to be shown by conky
# run daily by cron
FILE=~/.local/share/conky/taskwarriordue

task due:today

if [[ "$?" -eq 0 ]];
then
    #task due:today 2> /dev/null | tail -n +4 | tr -s '  ' | cut -d ' ' -f 5- | awk 'NF{NF-=1};1' > $FILE
    task due:today 2> /dev/null | tail -n +4 | tr -s '  ' | cut -d ' ' -f 4- | awk 'NF{NF-=1};1' > $FILE
else
    rm $FILE
fi
