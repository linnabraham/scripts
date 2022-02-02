#!/bin/bash

#echo "🔔$(task +PENDING count) :$(task +PENDING rc.context:none  count)"
contextname=$(task _get rc.context)
num=$(task end:today status:completed count)
#num=$(task +PENDING count)
echo "🔔$contextname : $num / $(task +PENDING rc.context:nopro count)"
