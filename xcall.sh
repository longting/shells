#!/bin/sh
pcount=$#
if((pcount==0));then
        echo no args...;
        exit;
fi
echo ==================master==================
$@
for((host=1; host<=3; host++)); do
        echo ==================server$host==================
        ssh server$host $@
done