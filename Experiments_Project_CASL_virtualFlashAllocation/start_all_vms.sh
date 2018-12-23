#!/bin/bash'
cd /etc/libvirt/qemu/
List_vms=`ls | grep vm`
echo $List_vms
for vm in $List_vms
do
 sudo virsh create $vm
  
done
cd /home/anuplal/1To_study/ProjectCasl/Experiments/

