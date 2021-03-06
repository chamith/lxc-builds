#! /bin/bash

ACTION=$1
LXC_CONTAINER=`basename "$0"`

if [ ! -n "$LXC_CONTAINER" ]
then
    echo "please provide an instance name."
    exit 0
fi

start(){
    echo "Starting the container '$LXC_CONTAINER'"
    lxc start $LXC_CONTAINER

    login
}

stop(){
    echo "Stopping container '$LXC_CONTAINER'"
    lxc stop $LXC_CONTAINER
}

login(){
    echo "Launching the Console"
    lxc exec $LXC_CONTAINER -- sudo --user ubuntu --login
}

backup(){
    backup_dir=$1
    echo "backup dir:$backup_dir"
    if [ ! -n "$backup_dir" ] || [ ! -d "$backup_dir" ]
    then
        echo "please provide a valid backup location."
        exit 0
    fi

    timestamp=`date "+%Y%m%d-%H%M%S"`
    backup_file=$backup_dir/$LXC_CONTAINER-$timestamp.tar.gz
    lxc export $LXC_CONTAINER $backup_file --verbose
    echo "backup of $LXC_CONTAINER successfully created as $backup_file"

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
    
    backup)
        backup $2
        exit 0
        ;;
    *)
        echo "unknown option $ACTION"
        ;;
esac