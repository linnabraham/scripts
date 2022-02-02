#!/bin/bash
#cmd="aws --output table ec2 describe-instances  --query 'Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,NetworkInterfaces:State.Name}'"

if  "$(aws --output table ec2 describe-instances  --query 'Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,NetworkInterfaces:State.Name}' | grep -q stopped)"  ; then
    echo "found"
else echo "not found"
fi
