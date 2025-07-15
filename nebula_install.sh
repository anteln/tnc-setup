#!/bin/bash

if [ -z "$1" ]; then
  HN=$(hostname)
else
  HN=$1
fi

./basics.sh $HN

./docker.sh

CR='\033[0;35m'
NC='\033[0m'

printf "\n${CR}Nebula setup - start${NC}"
printf "\n${CR}Nebula setup - folder - start${NC}\n\n"

mkdir -p /opt/stacks/nebula-sync
chmod 775 /opt/stacks/nebula-sync

printf "\n${CR}Nebula setup - folder - end${NC}"
printf "\n${CR}Nebula setup - configuration - start${NC}\n\n"

cp opt/stacks/nebula-sync/compose.yaml /opt/stacks/nebula-sync/compose.yaml
cp opt/stacks/nebula-sync/.env /opt/stacks/nebula-sync/.env

PIHOLE1=$(jq -r .hosts.\"ns-1\".address config.json)
PIHOLE2=$(jq -r .hosts.\"ns-2\".address config.json)

cd /opt/stacks/nebula-sync/

sed -i "s|host1|$PIHOLE1|g" .env
sed -i "s|host2|$PIHOLE2|g" .env

printf "\n${CR}Nebula setup - configuration - end${NC}"
printf "\n${CR}Nebula setup - run - start${NC}\n\n"

docker compose up -d

printf "\n${CR}Nebula setup - run - end${NC}"
printf "\n${CR}Nebula setup - verify - start${NC}\n\n"

sleep 15

docker ps | grep nebula

printf "\n${CR}Nebula setup - verify - end${NC}"
printf "\n${CR}Nebula setup - end${NC}\n"
