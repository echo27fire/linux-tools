#!/bin/bash
# Taylor Goodspeed
# Feb 21, 2022
#
# in class script 4 activity
#
# Script 4, take script3 imporve and add input

clear

#global vars
DIR=script4 #DIR THAT IS CHECKED FOR EXISTANCE AND FILE INSIDE
NAME="taylor goodspeed"
#x=00
#n=01
VAR1=$1 #VAR PASSED TO COMMAND
VAR2=$2 #VAR PASSED TO COMMAND
FILE=script4.txt
#output file vars
DDF=DD.File.$VAR1.M.Size
FF=Fallocate.FIle.$VAR1.M.Size
HF=Head.File.$VAR1.M.Size


#logging
# Everything below will go to the file 'log.out':


# script start
#test for input

if [ -z "$VAR1" ]
then
	VAR1=1
	echo "no input provided at script execution. Using default value for file size."
fi





#if then else conditional
if [ -d ~/$DIR ] && [ "$( ls -A ~/$DIR)" ]   #checks if $DIR exists and if its empty.
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
   echo "-------------------------------------"
   echo "-------------------------------------"

date +%m/%y/%d | tee  ~/$DIR/$FILE
echo "$NAME" | tee -a  ~/$DIR/$FILE
echo "we just made a simple text file wiht your name and date"
echo "at leaset we think its your name?"
uptime | tee -a ~/$DIR/$FILE
   echo "-------------------------------------"
   echo "-------------------------------------"
echo "creating files now"
   echo "-------------------------------------"
   echo "-------------------------------------"


while true;do
echo "File creation options"
echo "[D] DD command"
echo "[F] Fallocate command"
echo "[H] Head command"
echo "[A] ABORT SCRIPT"
read -p "What method should be used to make the files?" ANS
case $ANS in

[Dd]*)echo "DD option selected"
echo "creating file with 'DD' at ~/$DIR"
dd of=~/$DIR/$DDF if=/dev/zero bs=$VAR1"MB" count=1  #count=$VAR2"MB"
exit
;;
[Ff]*)echo "Fallocate selected"
echo "creating file with 'Fallocate' at ~/$DIR"
fallocate -l $VAR1"M" ~/$DIR/$FF
exit
;;
[Hh]*)echo "Head selected"
echo "creating file with 'Head' at ~/$DIR"
head -c $VAR1"M" /dev/urandom > ~/$DIR/$HF
exit
;;
[Aa]*)echo "ABORTING"
exit
;;
*) echo "select a option"

;;
esac
done

