#!/bin/bash

dnf install epel-release -y
dnf install elrepo-release -y
dnf install rpmfusion-free-release -y

dnf update -y

echo 'repo and update process complete'

dnf install cockpit -y
systemctl start cockpit.socket
systemctl enable cockpit.socket

echo 'cockpit configured'

systemctl disable --now firewalld.service
systemctl enable --now ufw.service
ufw disable
ufw allow http
ufw allow https
ufw allow ssh
ufw allow 9090
ufw enable

echo 'ufw enabbled'