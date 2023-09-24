#! /bin/bash

LXC_CONTAINER=$1
LXC_TEMPLATE=$2
LXC_STORAGE=$3

SCRIPT_PATH=`realpath $(dirname "$0")`
BUILD_SCRIPTS=$SCRIPT_PATH/build_scripts
TEMPLATES=$SCRIPT_PATH/templates
source $TEMPLATES/$LXC_TEMPLATE.sh

echo "Image:" $LXC_IMAGE
echo "Profile:" $LXC_PROFILE
echo "Packages:" $LXC_PACKAGES

delimiter=","
declare -a SCRIPT_ARRAY=($(echo $LXC_PACKAGES | tr "$delimiter" " "))

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

if [ ! -n "$LXC_TEMPLATE" ]
then
    echo "please provide a template name."
    exit 0
fi

if [ ! -n "$LXC_PROFILE" ]
then
    echo "please provide a profile name."
    exit 0
fi

if [ ! -n "$LXC_STORAGE" ]
then
    echo "please provide the storage name."
    exit 0
fi

lxc launch $LXC_IMAGE $LXC_CONTAINER -p default -p $LXC_PROFILE -s $LXC_STORAGE


sleep 5

echo "Setting up the new container with required software"

for script_name in ${SCRIPT_ARRAY[@]}; do
    script=$BUILD_SCRIPTS/$script_name.sh
    echo "executing $script" 
    cat $script | lxc exec $LXC_CONTAINER bash -
done

