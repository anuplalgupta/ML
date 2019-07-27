#!/bin/bash
val=`expr 1024 \* 512` # 512 MB-----------------------------------------------------
echo $val

val=`expr $val / 4 `
#val is the size of cache in unit of 4k blocks--------------------------------------
echo $val 
half_gb=$val

# loop  untll cache size reaches 6GB------------------------------------------------
#while [ $val -le 1572864 ]
#do
vm2flag=`cat /home/anuplal/sharedtoVM2/doneflag`
vm3flag=`cat /home/anuplal/sharedtoVM3/doneflag`
#vm4flag=`cat /home/anuplal/sharedtoVM4/doneflag`



#if condition to avoid the detach error for first iteration when no disk is attached 
#if [ $val -ge 131073 ]
#then

#while :
#do
vm2flag=`cat /home/anuplal/sharedtoVM2/doneflag`
vm3flag=`cat /home/anuplal/sharedtoVM3/doneflag`
#vm4flag=`cat /home/anuplal/sharedtoVM4/doneflag`

if [ $vm2flag -eq 1 ] || [ $vm3flag -eq 1 ] || [ $vm4flag -eq 1 ]
then
#break
echo "no error"
fi
#done

#virsh detach-disk vm2 sdb
#virsh detach-disk vm3 sdb
#virsh detach-disk vm4 sdb

#dd if=/dev/zero of=/media/SSD/c2.img bs=4k count=$val
#dd if=/dev/zero of=/media/SSD/c3.img bs=4k count=$val
#dd if=/dev/zero of=/media/SSD/c4.img bs=4k count=$val

#virsh attach-disk vm2 /media/SSD/c2.img sdb
#virsh attach-disk vm3 /media/SSD/c3.img sdb
#virsh attach-disk vm4 /media/SSD/c4.img sdb

#echo 1 > /home/anuplal/sharedtoVM2/attachflag
#echo 1 > /home/anuplal/sharedtoVM3/attachflag
#echo 1 > /home/anuplal/sharedtoVM4/attachflag

#while :
#do
af2=`cat /home/anuplal/sharedtoVM2/attachflag`
af3=`cat /home/anuplal/sharedtoVM3/attachflag`
af4=`cat /home/anuplal/sharedtoVM4/attachflag`


if [ $af2 -eq 2 ] && [ $af3 -eq 2 ] && [ $af4 -eq 2 ]
then
#break
echo "no error"
fi
#done

#virsh detach-disk vm2 sdb
#virsh detach-disk vm3 sdb
#virsh detach-disk vm4 sdb

#fi

#echo 0 > /home/anuplal/sharedtoVM2/doneflag
#echo 0 > /home/anuplal/sharedtoVM3/doneflag
#echo 0 > /home/anuplal/sharedtoVM4/doneflag

#dd if=/dev/zero of=/media/SSD/c2.img bs=4k count=$val
#dd if=/dev/zero of=/media/SSD/c3.img bs=4k count=$val
#dd if=/dev/zero of=/media/SSD/c4.img bs=4k count=$val

#virsh attach-disk vm2 /media/SSD/c2.img sdb
#virsh attach-disk vm3 /media/SSD/c3.img sdb
#virsh attach-disk vm4 /media/SSD/c4.img sdb

#write the cache size in MB to shaed folder to be read by guests--------------------
#cache_size=`expr $val / 256 `

#echo $cache_size > /home/anuplal/sharedtoVM2/cache_size
#echo $cache_size > /home/anuplal/sharedtoVM3/cache_size
#echo $cache_size > /home/anuplal/sharedtoVM4/cache_size

#echo 3 > /home/anuplal/sharedtoVM2/attachflag
#echo 3 > /home/anuplal/sharedtoVM3/attachflag
#echo 3 > /home/anuplal/sharedtoVM4/attachflag


#val=` expr $val + $half_gb `

#done
