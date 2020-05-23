#! /bin/bash
SCRIPT_PATH=`realpath $(dirname "$0")`

LXC_CONTAINER=$1
LXC_IMAGE=$2
LXC_PROFILE_PATH=$3
LXC_STORAGE=$4

LXC_PROFILE_NAME=$LXC_CONTAINER

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

if [ ! -n "$LXC_IMAGE" ]
then
    echo "please provide the image name."
    exit 0
fi

if [ ! -n "$LXC_PROFILE_PATH" ]
then
    echo "please provide the profile path."
    exit 0
fi

if [ ! -n "$LXC_STORAGE" ]
then
    echo "please provide the storage name."
    exit 0
fi

echo "Creating the custom profile '$LXC_PROFILE_NAME'"
lxc profile create $LXC_PROFILE_NAME
cat $LXC_PROFILE_PATH | lxc profile edit $LXC_PROFILE_NAME

echo "Launching the new container '$LXC_CONTAINER' using the image '$LXC_IMAGE'"
lxc launch $LXC_IMAGE $LXC_CONTAINER -p default -p $LXC_PROFILE_NAME -s $LXC_STORAGE