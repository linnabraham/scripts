#!/bin/bash
lastval=0
while :
do
        newval=`smartctl -A /dev/sda | awk '$2=="Load_Cycle_Count" {print $10}'`
        if [[ $newval != $lastval ]]    # i.e., anything has changed (here: load cycle count only)
        then
                date
                echo $newval
        fi
        lastval=$newval
        sleep 30    # or some other interval
    done
