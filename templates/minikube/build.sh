#! /bin/bash

LXC_IMAGE=ubuntu:18.04

SCRIPT_PATH=`realpath $(dirname "$0")`
BUILD_SCRIPTS=$SCRIPT_PATH/../../build_scripts
LXC_CONTAINER=$1
LXC_PROFILE_PATH=$SCRIPT_PATH/profile.yaml
LXC_STORAGE=$2

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

if [ ! -n "$LXC_STORAGE" ]
then
    echo "please provide the storage name."
    exit 0
fi

$BUILD_SCRIPTS/create-container.sh $LXC_CONTAINER $LXC_IMAGE $LXC_PROFILE_PATH $LXC_STORAGE

sleep 5

echo "Setting up the new container with required software"
cat $BUILD_SCRIPTS/dev-generic.sh | lxc exec $LXC_CONTAINER bash -
cat $BUILD_SCRIPTS/minikube.sh | lxc exec $LXC_CONTAINER bash -

