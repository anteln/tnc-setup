#!/bin/bash

./basics.sh $1

./docker.sh

CR='\033[0;35m'
NC='\033[0m'

printf "\n${CR}Traefik setup - start${NC}"
printf "\n${CR}Traefik setup - configure - start${NC}\n\n"

python3 -m venv venv
venv/bin/pip install jinja2
venv/bin/python3 traefik_config.py $1

printf "\n${CR}Traefik setup - configure - end${NC}"
printf "\n${CR}Traefik setup - package - start${NC}\n\n"

apt install apache2-utils -y

printf "\n${CR}Traefik setup - package - end${NC}"
printf "\n${CR}Traefik setup - folder - start${NC}\n\n"

mkdir -p /opt/stacks/traefik
chmod 775 /opt/stacks/traefik
mkdir -p /opt/stacks/traefik/data
chmod 775 /opt/stacks/traefik/data

printf "\n${CR}Traefik setup - folder - end${NC}"
printf "\n${CR}Traefik setup - configuration - start${NC}\n\n"

cp opt/stacks/traefik/compose.yaml /opt/stacks/traefik/compose.yaml
cp opt/stacks/traefik/cf_api_token /opt/stacks/traefik/cf_api_token
cp opt/stacks/traefik/.env /opt/stacks/traefik/.env

cp opt/stacks/traefik/data/traefik.yml /opt/stacks/traefik/data/traefik.yml
cp opt/stacks/traefik/data/config.yml /opt/stacks/traefik/data/config.yml
cp opt/stacks/traefik/data/acme.json /opt/stacks/traefik/data/acme.json
chmod 600 /opt/stacks/traefik/data/acme.json

cd /opt/stacks/traefik/

echo TRAEFIK_DASHBOARD_CREDENTIALS=$(htpasswd -nB admin) | sed -e s/\\$/\\$\\$/g > ./.env

printf "\n${CR}Traefik setup - configuration - end${NC}"
printf "\n${CR}Traefik setup - run - start${NC}\n\n"

docker network create proxy
# docker compose up -d

printf "\n${CR}Traefik setup - run - end${NC}"
printf "\n${CR}Traefik setup - verify - start${NC}\n\n"

sleep 15

docker ps | grep traefik

printf "\n${CR}Traefik setup - verify - end${NC}"
printf "\n${CR}Traefik setup - end${NC}\n"
