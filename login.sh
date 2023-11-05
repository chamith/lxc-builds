#! /bin/bash
LXC_CONTAINER=$1
CMD=$2

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

lxc exec $LXC_CONTAINER -- sudo -i -u ubuntu $CMD
