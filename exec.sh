#! /bin/bash
LXC_CONTAINER=$1
LXC_SCRIPT=$2

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

if [ ! -n "$LXC_SCRIPT" ]
then
    echo "please provide a script to execute."
    exit 0
fi

cat $LXC_SCRIPT | lxc exec $LXC_CONTAINER bash -
