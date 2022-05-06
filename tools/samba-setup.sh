#!/bin/bash
# date: May 6, 2022
# Auth: Taylor G.
# Name: Samba Setup Script


# Vars



# Functions
function banner () {
echo "----------------------------------------------------------"
}



function update () {
sudo apt update || echo "error with update process"
sudo apt upgrade || echo "error with upgrade process"
}



# Script Main
banner
echo" SAMBA INSTALL SCRIPT HAS BEEN INVOKED
banner

echo "starting preinstall update"
update # runs update fuction



