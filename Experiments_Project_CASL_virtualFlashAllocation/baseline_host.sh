#!/bin/bash
val=`expr 1024 \* 512` # 512 MB-----------------------------------------------------
echo $val

val=`expr $val / 4 `
#val is the size of cache in unit of 4k blocks--------------------------------------
echo $val 
vm2_val=$val
vm3_val=$val
vm4_val=$val


dd if=/dev/zero of=/media/SSD/c2.img bs=4k count=$val
dd if=/dev/zero of=/media/SSD/c3.img bs=4k count=$val
dd if=/dev/zero of=/media/SSD/c4.img bs=4k count=$val

virsh attach-disk vm2 /media/SSD/c2.img sdb
virsh attach-disk vm3 /media/SSD/c3.img sdb
virsh attach-disk vm4 /media/SSD/c4.img sdb
cache_size=`expr $val / 256 `


echo $cache_size > /home/anuplal/sharedtoVM2/cache_size
echo $cache_size > /home/anuplal/sharedtoVM3/cache_size
echo $cache_size > /home/anuplal/sharedtoVM4/cache_size


while :
do

baseline_vm2_done=`cat /home/anuplal/sharedtoVM2/baseline_done`
baseline_vm3_done=`cat /home/anuplal/sharedtoVM3/baseline_done`
baseline_vm4_done=`cat /home/anuplal/sharedtoVM4/baseline_done`

if [ -z "$baseline_vm2_done" ] || [ -z "$baseline_vm3_done" ] || [ -z "$baseline_vm4_done" ]
then
continue
fi


if [ $baseline_vm2_done -eq 1 ] && [ $baseline_vm3_done -eq 1 ] && [ $baseline_vm4_done -eq 1 ]
then
break
fi

double_flag_vm2=`cat /home/anuplal/sharedtoVM2/double_me`

if [ $double_flag_vm2 -eq 1 ] && [ $baseline_vm2_done -eq 0 ]
then
virsh detach-disk vm2 sdb
vm2_val=$(( vm2_val \* 2 ))
vm2_cache_size=`expr $vm2_val / 256 `

echo $vm2_cache_size > /home/anuplal/sharedtoVM2/cache_size
dd if=/dev/zero of=/media/SSD/c2.img bs=4k count=$vm2_val
virsh attach-disk vm2 /media/SSD/c2.img sdb
echo 1 > /home/anuplal/sharedtoVM2/double_attached

while :
do 
d_a=`cat /home/anuplal/sharedtoVM2/double_attached`
if [ $d_a -eq 2 ]
then
virsh detach-disk vm2 sdb
dd if=/dev/zero of=/media/SSD/c2.img bs=4k count=$vm2_val
virsh attach-disk vm2 /media/SSD/c2.img sdb
echo 3 > /home/anuplal/sharedtoVM2/double_attached
break
fi
done


fi

double_flag_vm3=`cat /home/anuplal/sharedtoVM3/double_me`

if [ $double_flag_vm3 -eq 1 ]  && [ $baseline_vm2_done -eq 0 ]
then
virsh detach-disk vm3 sdb
vm3_val=$(( vm3_val \* 2 ))
vm3_cache_size=`expr $vm3_val / 256 `
echo $vm3_cache_size > /home/anuplal/sharedtoVM3/cache_size
dd if=/dev/zero of=/media/SSD/c3.img bs=4k count=$vm3_val
virsh attach-disk vm3 /media/SSD/c3.img sdb
echo 1 > /home/anuplal/sharedtoVM3/double_attached
while :
do
d_a=`cat /home/anuplal/sharedtoVM3/double_attached`
if [ $d_a -eq 2 ]
then
virsh detach-disk vm3 sdb
dd if=/dev/zero of=/media/SSD/c3.img bs=4k count=$vm3_val
virsh attach-disk vm3 /media/SSD/c3.img sdb
echo 3 > /home/anuplal/sharedtoVM3/double_attached
break
fi
done

fi


double_flag_vm4=`cat /home/anuplal/sharedtoVM4/double_me`
if [ $double_flag_vm4 -eq 1 ] && [ $baseline_vm2_done -eq 0 ]
then
virsh detach-disk vm4 sdb
vm4_val=$(( vm4_val \* 2 ))
vm4_cache_size=`expr $vm4_val / 256 `
echo $vm4_cache_size >  /home/anuplal/sharedtoVM2/cache_size
dd if=/dev/zero of=/media/SSD/c4.img bs=4k count=$vm4_val
virsh attach-disk vm4 /media/SSD/c4.img sdb
echo 1 > /home/anuplal/sharedtoVM4/double_attached
while :
do
d_a=`cat /home/anuplal/sharedtoVM4/double_attached`
if [ $d_a -eq 2 ]
then
virsh detach-disk vm4 sdb
dd if=/dev/zero of=/media/SSD/c4.img bs=4k count=$vm4_val
virsh attach-disk vm4 /media/SSD/c4.img sdb
echo 3 > /home/anuplal/sharedtoVM4/double_attached
break
fi
done
fi

sleep 60

done

