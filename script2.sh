#!/bin/bash
# Febuary 7 2022
# Taylor Goodspeed Slack

clear

#prep work area
yes | rm -r ~/script2



#vars
name='Taylor Goodspeed'
dt=`date`
lusr=`whoami`
utime=`uptime`
wkdir=`pwd`

#script start

mkdir ~/script2;touch ~/script2/script2.txt  #touch if script2.txt prolly not needed
cd ~/script2
printf "Today is $dt\n My name is $name and I am logged in as $lusr\n The system as been running for $utime." | tee -a script2.txt

truncate -s 5M ./5mbFile
# dd of=~/script2/5mbfile if=/dev/zero bs=1 count 6


chmod -w script2.txt

echo "script2 complete" | tee -a script2.out
echo "directory script2 created at ~/script2/" | tee -a script2.out
echo "txt file and outputfile created in ~/script2" | tee -a script2.out
echo "5mbfile created in ~/script2/" | tee -a script2.out
echo "script2 ended with exit code: $?"  | tee -a script2.out

echo "LOCKING LOG FILE"

chmod 640 script2.out
sudo chown centos2 script2.out
