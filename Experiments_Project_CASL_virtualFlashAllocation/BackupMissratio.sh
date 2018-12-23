#!/bin/bash
month=`date -R | cut -b 9-11`
date=`date -R | cut -b 6-7`
t=`date -R | cut -b 18-25`
echo "enter bechmarkname"
read benchname
directory=$benchname$month$date$t
echo $directory
mkdir /home/anuplal/1To_study/ProjectCasl/Experiments/backupvmMissratio/$directory
cp /home/anuplal/sharedtoVM2/vm2missratio /home/anuplal/1To_study/ProjectCasl/Experiments/backupvmMissratio/$directory
cp /home/anuplal/sharedtoVM3/vm3missratio /home/anuplal/1To_study/ProjectCasl/Experiments/backupvmMissratio/$directory
cp /home/anuplal/sharedtoVM4/vm4missratio /home/anuplal/1To_study/ProjectCasl/Experiments/backupvmMissratio/$directory
