#!/bin/bash

./basics.sh $1 $2 $3

./docker.sh

printf "\nTraefik setup - start"
printf "\nTraefik setup - package - start\n\n"

apt install apache2-utils -y

printf "\nTraefik setup - package - end"
printf "\nTraefik setup - folder - start\n\n"

mkdir -p /opt/stacks/traefik
chmod 775 /opt/stacks/traefik
mkdir -p /opt/stacks/traefik/data
chmod 775 /opt/stacks/traefik/data

printf "\nTraefik setup - folder - end"
printf "\nTraefik setup - configuration - start\n\n"

cp opt/stacks/traefik/compose.yaml /opt/stacks/traefik/compose.yaml
cp opt/stacks/traefik/cf_api_token /opt/stacks/traefik/cf_api_token
cp opt/stacks/traefik/.env /opt/stacks/traefik/.env

cp opt/stacks/traefik/data/traefik.yml /opt/stacks/traefik/data/traefik.yml
cp opt/stacks/traefik/data/config.yml /opt/stacks/traefik/data/config.yml
cp opt/stacks/traefik/data/acme.json /opt/stacks/traefik/data/acme.json
chmod 600 /opt/stacks/traefik/data/acme.json

cd /opt/stacks/traefik/

sed -i "s|LOCALDOMAIN|$4|g" .env
sed -i "s|YOUREMAIL|$5|g" data/traefik.yml

echo $6 > ./cf_api_token

echo TRAEFIK_DASHBOARD_CREDENTIALS=$(htpasswd -nB admin) | sed -e s/\\$/\\$\\$/g > ./.env

printf "\nTraefik setup - configuration - end"
printf "\nTraefik setup - run - start\n\n"

docker network create proxy
# docker compose up -d

printf "\nTraefik setup - run - end"
printf "\nTraefik setup - verify - start\n\n"

sleep 15

docker ps | grep traefik

printf "\nTraefik setup - verify - end"
printf "\nTraefik setup - end\n"
