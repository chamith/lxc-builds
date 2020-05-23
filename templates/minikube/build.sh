#! /bin/bash
LXC_CONTAINER=$1
LXC_IMAGE=ubuntu:18.04
LXC_PROFILE=minikube_new
LXC_STORAGE=lxd-storage
SCRIPT_PATH=`realpath $(dirname "$0")`

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

echo "Creating the custom profile '$LXC_PROFILE'"
lxc profile create $LXC_PROFILE
cat $SCRIPT_PATH/profile.yaml | lxc profile edit $LXC_PROFILE

echo "Launching the new container '$LXC_CONTAINER' using the image '$LXC_IMAGE'"
lxc launch $LXC_IMAGE $LXC_CONTAINER -p default -p $LXC_PROFILE -s $LXC_STORAGE

sleep 5

echo "Setting up the new container with required software"
cat $SCRIPT_PATH/__build_steps__ | lxc exec $LXC_CONTAINER bash -
