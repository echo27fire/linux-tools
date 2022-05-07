#!/bin/bash
# Vars
USER=$(whoami) # the user runninhg the script
smbdir=/mnt/samba # main path to smb shares
IFLX=/mnt/samba/Influx # path to influxdb share
TGRF=/mnt/samba/Telegraf # path to telegraf share
SMBCONF=smb.conf # file name for smb main config file
SMBSHARE=smb-shares.conf # file name for smb shares config
SMBNAMES=smb-names.conf
SMBGRP=sambausr # group for samba users
EXTRAPATH=/boot/config/
SMBEXTRA=/smb-extra.conf




# Functions
# just makes a banner
function banner () {
echo "----------------------------------------------------------"
}

# System Update
function update () {
sudo apt update || echo "error with update process"
sudo apt upgrade -y || echo "error with upgrade process"
}

# Makes a Backup for the initial config
function smb-backup () {
sudo cp /etc/samba/smb.conf{,.backup}
}

# Blanks ane existing files
function smb-blank () {
  #blanks out config files
  sudo echo ' ' > ~/$SMBCONF # blanks out existing custom conf file if it exists change to if statement?
  sudo echo ' ' > ~/$SMBSHARE # blanks out existing custom conf file if it exists change to if statement?
}

# Installs SAMBA
function smb-dl () {
sudo apt update -y
sudo apt -y install samba

}

# Make DIRs for shares
function smb-makeshare (){
sudo mkdir -p  $IFLX $TGRF
}

#-----------------------------------------------#
#						#
#	functions for making config files	#
#						#
#						#
#-----------------------------------------------#

function smbstart (){
sudo systemctl restart smbd nmbd
}


function smb-conf (){

cat << EOF >> /etc/samba/$SAMBCONF
# Configure correct UTP
  unix charset = UTF-8
# Change this to the workgroup/NT-domain name your Samba server will be part of
   workgroup = WORKGROUP
   bind interfaces only = yes

# Set share configuration at the end
[TICK]
   path = $SMBDIR
   writable = yes
   guest ok = yes
   guest only = yes
   create mode = 0777
   directory mode = 0777
EOF
}














#-----------------------------------------------#
#                                               #
#       	start of script   	        #
#                                               #
#                                               #
#-----------------------------------------------#
# Phase 1 - Install
smb-dl
smb-backup
smb-makeshare
smb-conf
smbstart

