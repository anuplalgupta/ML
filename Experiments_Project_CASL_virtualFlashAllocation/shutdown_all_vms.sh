#!/bin/bash

    LIST_VM=`virsh list | grep running | awk '{print $2}'`
    TIMEOUT=90
    DATE=`date -R`
    LOGFILE="/var/log/shutdownkvm.log"

#    if [ "x$activevm" =  "x" ]
 #   then
  #   exit 0
 #	fi

    for activevm in $LIST_VM
    do
     PIDNO=`ps ax | grep $activevm | grep kvm | cut -c 1-6 | head -n1`
     echo "$DATE : Shutdown : $activevm : $PIDNO"
     virsh shutdown $activevm	
     COUNT=0
     while [ "$COUNT" -lt "$TIMEOUT" ]
     do
    ps --pid $PIDNO 
    if [ "$?" -eq "1" ]
    then
    COUNT=110
    else
    sleep 5
    COUNT=$(($COUNT+5))
    fi
    done
    if [ $COUNT -lt 110 ]
    then
    echo "$DATE : $activevm not successful force shutdown"
    virsh destroy $activevm 
    fi
    done
