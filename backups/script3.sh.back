#!/bin/bash
# Taylor Goodspeed
# Feb 14, 2022
#
#
#
#
# in class script 3 activity
#
# conditions and loops
# 
# 1. if script dir exists, no not make new dir
# 2. verify the directory is empty before doing anything else
# 3. create multiple files with a loop [for, while, untill]
#
#global vars
DIR=script3
NAME="taylor goodspeed"
x=00
n=01
#logging
# Everything below will go to the file 'log.out':
# script start
echo "-------------------------------------"
echo "-------------------------------------"
#if then else conditional
if [ -d ~/$DIR ]
then
   echo " I'm sorry dave, that folder already exists."
else
echo "$DIR does not exist, making it now"
mkdir ~/$DIR
fi
if [ "$(ls -A ~/$DIR)" ]
then
   echo "Not only does it exist, but it has stuff in it!"
   echo "lets get rid of it before further testing shall we?"
   echo "-------------------------------------"
   printf "I hope you made a backup....\n....you did make a backup, right? \n"
   echo "-------------------------------------"
   rm ~/$DIR/*
else
  echo "Theres nothing in the $DIR folder so we can do what we want"
fi
echo " lets fill that dir up with lots of junk now, shall we?"
date +%m/%y/%d | tee  ~/$DIR/script3.txt
echo "$NAME" | tee -a  ~/$DIR/script3.txt
echo "we just made a simple text file wiht your name and date"
echo "at leaset we think its your name?"
uptime | tee -a ~/$DIR/script3.txt
echo "-------------------------------------"
echo "-------------------------------------"
echo "now how many junk files shold we fill the rest of the $DIR directory with?"
read JUNKFILE
#read user input
echo "-------------------------------------"
echo "What size should those $JUNKFILE be?"
read JUNKSIZE
#read user input
echo "Just so we're clear, you want to make $JUNKFILE files at $JUNKSIZE a pop?"
#yes / no input
while true; do
    read -p "Is this correct?" yn
    case $yn in
        [Yy]* ) echo "lets make stuff";
while [ $x != "$JUNKFILE" ]
do
echo "this is my script making junk $x times"
dd of=~/$DIR/script3.junk.0$n if=/dev/zero bs="$JUNKSIZE" count=1
x=$(( $x + 1 ))
n=$(( $n +1 ))

done;
break;;
        [Nn]* ) echo "so I guess I'll do nothing then"; exit;;
        * ) echo "It's  yes or no question.";;
    esac
done
