#!/bin/bash
# date: May 6, 2022
# Auth: Taylor G.
# Name: Samba Setup Script


# Vars
USER=$(whoami)
smbdir=/samba

# Functions
function banner () {
echo "----------------------------------------------------------"
}

function update () {
sudo apt update || echo "error with update process"
sudo apt upgrade || echo "error with upgrade process"
}

function smb-backup () {
sudo cp /etc/samba/smb.conf{,.backup}
}

function CONF-MAKE () {
cat << EOF >> /home/$USER/smb.conf
[global]
# Configure correct UTP
  unix charset = UTF-8
# Change this to the workgroup/NT-domain name your Samba server will be part of \
   workgroup = WORKGROUP
   bind interfaces only = yes

# Set share configuration at the end
[Docs] \
   path = $smbdir
   writable = yes
   guest ok = yes
   guest only = yes
   create mode = 0664
   directory mode = 0664
EOF
}

# Script Main
# stage 0 - intro
banner
echo "SAMBA INSTALL SCRIPT HAS BEEN INVOKED"
banner

# stage 1 - update
echo "starting preinstall update as $USER"
update 1>/home/"$USER"/smb-update.log #runs update fuction
echo "update complete ready to install"

# stage 2  make DIRs and install samba
echo "making SAMBA directory"
sudo mkdir -p $smbdir || echo "error with directory creation"
echo "installing samba and samba tools"
sudo apt install samba cifs-utils || echo "error installing packages"
clear;echo "samba install complete, making bakup of smb.conf"

# stage 3 - backup inital config & make custom config
smb-backup # config cp to user home dir.
sudo chmod 664 -R /$smbdir
CONF-MAKE
#sudo cat ~/smb.conf > /etc/samba/smb.conf
sudo cat  ~/smb.conf | sudo tee /etc/samba/smb.conf
