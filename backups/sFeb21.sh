#!/bin/bash
# Taylor Goodspeed Date Feb 21, 22
#
#
#
# script 4
#
#
#
# Passing Marameters at the command promt
#
#
# VARS
LOG=s4.log 
v1=$1 
v2=$2 
v3=$3 
echo "v1:$v1 v2:$v2 v3:$v3"


#option Aa if if a is passed as a variable, script runs in automatic mode and read from a file
# if option A is not passed script runs in manual mode, and reads user provided input


if [[ $v1 = [Aa] ]] #start of ifn1 
then 
echo "running in automatic mode" 
echo "have you created a values file?"

head -n 2 $(values.txt)


else 

echo "running in manual mode"
echo "Value #1 is $1"
echo " Value #2 is $2" 2>>$LOG;
SUM=$(($1 + $2)) 2>>$LOG
echo "The sum of both is $SUM" 2>>$LOG

fi #end of ifn1
