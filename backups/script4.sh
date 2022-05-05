#!/bin/bash
# Taylor Goodspeed
# Feb 21, 2022
#
#
#
#
# in class script 4 activity
#
# conditions and loops
# 
# 1. if script dir exists, no not make new dir
# 2. verify the directory is empty before doing anything else
# 3. create multiple files with a loop [for, while, untill]
#

clear

#global vars
DIR=script4 #DIR THAT IS CHECKED FOR EXISTANCE AND FILE INSIDE
NAME="taylor goodspeed"
x=00
n=01
VAR1=$1 #VAR PASSED TO COMMAND
VAR2=$2 #VAR PASSED TO COMMAND
FILE=script4.txt
FILE2=junkfiile.is.junk

#logging
# Everything below will go to the file 'log.out':


# script start
#if then else conditional
if [ -d ~/$DIR ] && [ "$(s -A ~/$DIR)" ]   #checks if $DIR exists and if its empty.
then
   echo "I'm sorry dave, that folder already exists and contains files"
   echo "lets make some room"
   echo "lets get rid of it before further testing shall we?"
   printf "I hope you made a backup....\n....you did make a backup, right? \n"
   rm ~/$DIR/*
else
   echo "$DIR either does not exist, or it is empty."
   mkdir ~/$DIR 2>/dev/null
fi

   echo "-------------------------------------"
   echo "-------------------------------------"
   echo "DIRECTORY PROCESSING COMPLETE"
   echo "-------------------------------------"
   echo "-------------------------------------"

echo "STARTING FILE PROCESSING"
date +%m/%y/%d | tee  ~/$DIR/$FILE.txt
echo "$NAME" | tee -a  ~/$DIR/$FILE.txt
echo "we just made a simple text file wiht your name and date"
echo "at leaset we think its your name?"
uptime | tee -a ~/$DIR/$FILE.txt

echo "creating files now"
echo "making $VAR1 files of $VAR2 size"
echo "File creation options"
echo "[D] DD command"
echo "[F] Fallocate command"
echo "[H] Head command"
echo "[A] ABORT OPERATIONS"


#while ;do
read -p "What method should be used to make the files?" ANS
case $ANS in

[Dd]*)echo "DD option selected"
dd of =~/$DIR/$FILE2 if=/dev/zero bs="$VAR2" count="$VAR1"
;;
[Ff]*)echo "Fallocate selected"

;;
[Hh]*)echo "Head selected"

;;
[Aa]*)echo "ABORTING";exit

;;
*) echo "select a option"

;;
esac
#done

