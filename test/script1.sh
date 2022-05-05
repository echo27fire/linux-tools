#!/bin/bash
# taylor goodspeed-slack
# NOS-125 SP22
# Script1 - folder file creation
# makes a dir named Script1 and creates a 5M file


echo "making dir Script1 in current directory"
mkdir Script1
echo "truncating a 5mb file nameed 5mbFile in Script1 dir."
truncate -s 5MB ./Script1/5mbFile
echo "file creation complete"
echo "verifying dir contents"
ls -l ./Script1/
ls -l ./Script1/ > ~/script1.out
echo "end of script"
echo "log of files created in home dir called script1.out"
