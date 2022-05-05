#!/bin/bash

#test=$(date)
#test2=`date`

#echo "today is $test"
#echo "today is $test2"

#touch testfile.jpg
#today=$(date +%y%m%d)
#ls ./*jpg
#ls ./*jpg > log.$today
#test=$(ls *.jpg)
#mv $test $test`$today`


workingfile=find $(pwd) -type f -name '*.jpg'
echo $workingfile
