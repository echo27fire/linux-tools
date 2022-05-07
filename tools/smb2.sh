#!/bin/bash
# Vars
USER=$(whoami) # the user runninhg the script
smbdir=/home/share/ # main path to smb shares
IFLX=$smbdir/Influx # path to influxdb share
TGRF=$smbdir/Telegraf # path to telegraf share
SMBCONF=smb.conf # file name for smb main config file
SMBSHARE=smb-shares.conf # file name for smb shares config
SMBNAMES=smb-names.conf
SMBGRP=sambashare # group for samba users




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

[noc]
path = $SMBDIR/noc
read only = no
browseable = yes
force create mode = 0660
force directory mode = 2770
valid users = noc root taylor


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
sudo chgrp $SMBGRP $smbdir


#add share specific user
mkdir $smbdir/noc
sudo useradd -M -d $smbdir/noc -s /user/sbin/nologin -G $SMBGRP noc
chown noc:$SMBGRP $smbdir
chmod 2770 /mnt/samba/noc

#configure user login
sudo smbpasswd -a noc
sudo smbpasswd -e noc





# end of script - restart samba service
smbstart

