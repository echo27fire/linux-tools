#!/bin/bash
KEY=$(cat ./vault.key)
echo $KEY

#docker run -d --name vaultwarden \
#--restart=always \
#-v /docker/appdata/vaultwarden:/data/ \
#-p  81:80 -e WEBSOCKET_ENABLED=true -p 3012:3012 \
#-e ADMIN_TOKEN=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 \
#-e SIGNUPS_ALLOWED=false \
#vaultwarden/server:latest

#clear;docker ps -a | grep vaultwarden
