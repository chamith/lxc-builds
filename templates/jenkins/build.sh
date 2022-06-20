#! /bin/bash
LXC_CONTAINER=$1
LXC_IMAGE=images:ubuntu/20.04
LXC_PROFILE_NAME=jenkins_new
LXC_STORAGE=lxd-storage
SCRIPT_PATH=`realpath $(dirname "$0")`
LXC_PROFILE_PATH=$SCRIPT_PATH/profile.yaml

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

kernel_release=`uname -r`
echo "kernel: $kernel_release"
echo "Creating the custom profile '$LXC_PROFILE_NAME'"
lxc profile create $LXC_PROFILE_NAME
cat $LXC_PROFILE_PATH | sed "s^KERNEL_RELEASE^$kernel_release^g" | lxc profile edit $LXC_PROFILE_NAME

echo "Launching the new container '$LXC_CONTAINER' using the image '$LXC_IMAGE'"
lxc launch $LXC_IMAGE $LXC_CONTAINER -p default -p $LXC_PROFILE_NAME

sleep 5

echo "Setting up the new container with required software"
cat $SCRIPT_PATH/build_scripts/jenkins.sh | lxc exec $LXC_CONTAINER bash -
