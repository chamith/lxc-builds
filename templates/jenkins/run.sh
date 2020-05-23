#! /bin/bash

ACTION=$1
LXC_CONTAINER=$2

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

start(){
    echo "Starting the container '$LXC_CONTAINER'"
    lxc start $LXC_CONTAINER

    echo "Setting up iptables for Jenkins"
    lxc exec $LXC_CONTAINER -- iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
}

stop(){
    echo "Stopping the container '$LXC_CONTAINER'"
    lxc stop $LXC_CONTAINER
}

login(){
    echo "Launching the Console"
    lxc exec $LXC_CONTAINER bash
}

case "$ACTION" in
    start)
        start
        exit 0
        ;;

    stop)
        stop
        exit 0
        ;;

    restart)
        stop
        start
        exit 0
        ;;

    login)
        login
        exit 0
        ;;
    *)
        echo "unknown option $ACTION"
        ;;
esac