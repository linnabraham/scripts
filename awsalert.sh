#!/bin/bash

aws --output table ec2 describe-instances  --query 'Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,NetworkInterfaces:State.Name}' \
    | grep running

out=$(echo $?)

if [ "$out" -eq 0 ]
then
    echo "VM Running"
    #notify-send "VM Running"
fi
