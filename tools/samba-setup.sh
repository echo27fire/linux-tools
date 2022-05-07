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
[Influx] \
   path = $smbdir/influx
   writable = yes
   browseable = yes
   valid users = taylor noc
   write list = taylor noc


[Telegraf]
   path = $smbdir/Telegraf
   writeable = yes
   browseable = yes
   valid users = taylor noc
   write list = taylor

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
echo "samba install complete, making bakup of smb.conf"

# stage 3 - backup inital config & make custom config
smb-backup # config cp to user home dir.
sudo chmod 664 -R /$smbdir
sudo echo ' ' > ~/smb.conf # blanks out existing custom conf file if it exists change to if statement?
CONF-MAKE
#sudo cat ~/smb.conf > /etc/samba/smb.conf
sudo cat  ~/smb.conf | sudo tee /etc/samba/smb.conf

# stage 4 secure smb share
sudo groupadd samba
sudo usermod -aG samba $USER
sudo useradd noc && sudo usermod -G samba noc
sudo passwd -d noc
mkdir /samba/influx;sudo chown noc:samba -R /samba/influx && sudo chmod 2770 /samba/influx


