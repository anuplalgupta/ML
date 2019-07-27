#!/bin/bash
> /home/anuplal/1To_study/ProjectCasl/Experiments/testfile
echo 1 > /home/anuplal/1To_study/ProjectCasl/Experiments/testfile
var=`cat /home/anuplal/1To_study/ProjectCasl/Experiments/testfile`
if [ -z "$var" ]
then
echo "var empty"
else
echo $var

fi
