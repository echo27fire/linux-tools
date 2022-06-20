#!/bin/bash
KEY=$(cat ./vault.key)
echo $KEY

# start of docker script
docker run -d --name vaultwarden \
--restart=always \
-v /docker/appdata/vaultwarden:/data/ \
-p  85:443 \
-p 3012:3012 \
-e WEBSOCKET_ENABLED=true \
-e ADMIN_TOKEN="$KEY" \
-e SIGNUPS_ALLOWED=false \
vaultwarden/server:latest
echo 'run complete'
