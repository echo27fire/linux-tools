#!/bin/bash

#test=$(date)
#test2=`date`

#echo "today is $test"
#echo "today is $test2"


today=$(date +%y%m%d)
ls /usr/bin -al > log.$today
