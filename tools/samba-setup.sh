#!/bin/bash
# date: May 6, 2022
# Auth: Taylor G.
# Name: Samba Setup Script


# Vars
USER=$(whoami) # the user runninhg the script
smbdir=/mnt/samba # main path to smb shares
IFLX=/mnt/samba/Influx # path to influxdb share
TGRF=/mnt/samba/Telegraf # path to telegraf share
SMBCONF=smb.conf # file name for smb main config file
SMBSHARE=smb-shares.conf # file name for smb shares config
SMBNAMES=smb-names.conf
SMBGRP=sambausr # group for samba users

# Functions
# just makes a banner
function banner () {
echo "----------------------------------------------------------"
}

# updates the system
function update () {
sudo apt update || echo "error with update process"
sudo apt upgrade -y || echo "error with upgrade process"
}

# backups the initial samba config file
function smb-backup () {
sudo cp /etc/samba/smb.conf{,.backup}
}

# generates smb config file
function smb-conf () {
cat << EOF >> /home/$USER/$SMBCONF
[global]
        # configurable identification
        include = /etc/samba/smb-names.conf

        # log stuff only to syslog
        logging = syslog@0

        # we don't do printers
        show add printer wizard = No
        disable spoolss = Yes
        load printers = No
        printing = bsd
        printcap name = /dev/null

        # disable aio by default
        aio read size = 0
        aio write size = 0

        # misc.
        invalid users = root
        unix extensions = No
        wide links = Yes
        use sendfile = Yes

        # ease upgrades from Samba 3.6
        acl allow execute always = Yes
        # permit NTLMv1 authentication
        ntlm auth = Yes

        # hook for user-defined samba config
        include = /boot/config/smb-extra.conf

        # auto-configured shares
        include = /etc/samba/smb-shares.conf
EOF
sudo cat  ~/smb.conf | sudo tee /etc/samba/$SMBCONF

}

# generates smb share file
function smb-share () {
  cat << EOF >> /home/$USER/$SMBSHARE
# Set share configuration at the end
[Influx]
  path = $IFLX
  commect =
  browseable = yes
  # public
  public = yes
  writeable = yes


[Telegraf]
   path = $TGRF
   commect =
   browseable = yes
   # public
   public = yes
   writeable = yes

EOF
sudo cat  ~/smb.conf | sudo tee /etc/samba/$SMBSHARE
}

function smb-names () {
cat << EOF >> /home/$USER/$SMBNAMES
# Generated names
netbios name = Influx-Host
server string = Influx-Host
hide dot files = No
disable netbios = No
server min protocol = NT1
local master = yes
os level = 100
security = USER
workgroup = WORKGROUP
map to guest = Bad User
passdb backend = smbpasswd
null passwords = Yes
idmap config * : backend = tdb
idmap config * : range = 3000-7999
map archive = No
map hidden = No
map system = No
map readonly = Yes
create mask = 0777
directory mask = 0777
EOF
sudo cat ~/$SMBNAMES | sudo tee /etc/samba/$SMBNAMES
}

# blanks out any existing smb config files located in the users home dir
function smb-blank () {
  #blanks out config files
  sudo echo ' ' > ~/$SMBCONF # blanks out existing custom conf file if it exists change to if statement?
  sudo echo ' ' > ~/$SMBSHARE # blanks out existing custom conf file if it exists change to if statement?


}


# Script Main
# stage 0 - intro
banner
echo "SAMBA INSTALL SCRIPT HAS BEEN INVOKED"
banner

# stage 1 - update and install
update 1>/home/"$USER"/smb-update.log #runs update fuction
sudo mkdir -p $smbdir || echo "error at line #146"
sudo apt install samba cifs-utils -y 1>~/smb-update.log || echo "error installing packages"

# stage 2 - backup inital config, generate custom configs, and move to smb config dir
smb-backup # config cp to user home dir.
smb-blank
smb-conf
smb-share
smb-names

# stage 3 secure smb share
sudo groupadd $SMBGRP
sudo usermod -aG $SMBGRP $USER
sudo useradd noc && sudo usermod -G $SMBGRP noc
sudo passwd -d noc
sudo mkdir $TGRF $IFLX || echo "errro at line #161"


# setup users and permissions
sudo chgrp $SMBGRP -R $smbdir
sudo chmod 774 -R  $smbdir
sudo systemctl restart smbd nmbd
