#!/bin/bash
KEY=$(cat ./vault.key)
echo '----------------------------------------'
echo '      key for admin panel is $KEY'
echo '         starting deployment'
echo '----------------------------------------'

 sudo docker run -d --name vaultwarden \
 -v /docker/appdata/vaultwarden:/data \
 -e WEBSOCKET_ENABLED=false \
 -e ADMIN_TOKEN="$KEY" \
 -e SIGNUPS_ALLOWED=ture \
 -p 8080:80 \
 -p 3012:3012 \
 --restart on-failure \
 vaultwarden/server:latest

echo '----------------------------------------'
echo '         deployment complete '
echo '----------------------------------------'



