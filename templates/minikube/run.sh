#! /bin/bash

ACTION=$1
LXC_CONTAINER=$2
API_SERVER_NAME=$LXC_CONTAINER.lxc

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

start(){
    echo "Starting the container '$LXC_CONTAINER'"
    lxc start $LXC_CONTAINER

    echo "Starting minikube"
    lxc exec $LXC_CONTAINER -- minikube start --vm-driver=none --apiserver-name=$API_SERVER_NAME --extra-config=kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
    lxc exec $LXC_CONTAINER -- minikube update-context
}

stop(){
    echo "Stopping minikube services on the container"
    lxc exec $LXC_CONTAINER -- minikube stop

    echo "Stopping container '$LXC_CONTAINER'"
    lxc stop $LXC_CONTAINER
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

    *)
        echo "unknown option $ACTION"
        ;;
esac