#!/bin/bash
List_cache=`cat /home/anuplal/1To_study/ProjectCasl/Experiments/optimalcacheSize`
i=2
for cache_size in $List_cache
do
val=`echo "$cache_size * 1024" | bc | cut -d"." -f1`
echo $val > /home/anuplal/sharedtoVM$i/optimalcacheSize
val=`echo "$val * 1024" | bc`
val=`echo "$val / 4 " | bc | cut -d"." -f1`
path=coptimal$i.img
dd if=/dev/zero of=/media/SSD/$path bs=4k count=$val
virsh attach-disk vm$i /media/SSD/$path sdb
echo $path
i=$(( i + 1 ))
echo $val
done
