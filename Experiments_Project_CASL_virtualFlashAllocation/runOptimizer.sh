#!/bin/bash
cp /home/anuplal/sharedtoVM2/vm2missratio /home/anuplal/1To_study/ProjectCasl/Experiments/vm2stat
cp /home/anuplal/sharedtoVM3/vm3missratio /home/anuplal/1To_study/ProjectCasl/Experiments/vm3stat
cp /home/anuplal/sharedtoVM4/vm4missratio /home/anuplal/1To_study/ProjectCasl/Experiments/vm4stat
matlab -nojvm -nodisplay -nosplash < /home/anuplal/1To_study/ProjectCasl/Experiments/optimize.m

