#!/bin/bash

./basics.sh $1

./docker.sh

CR='\033[0;35m'
NC='\033[0m'

printf "\n${CR}Openremote setup - start${NC}"
printf "\n${CR}Openremote setup - folder - start${NC}\n\n"

mkdir -p /opt/stacks/openremote
chmod 775 /opt/stacks/openremote

printf "\n${CR}Openremote setup - folder - end${NC}"
printf "\n${CR}Openremote setup - configuration - start${NC}\n\n"

cp opt/stacks/openremote/compose.yaml /opt/stacks/openremote/compose.yaml

cd /opt/stacks/openremote/

printf "\n${CR}Openremote setup - configuration - end${NC}"
printf "\n${CR}Openremote setup - run - start${NC}\n\n"

# docker compose up -d

printf "\n${CR}Openremote setup - run - end${NC}"
printf "\n${CR}Openremote setup - verify - start${NC}\n\n"

sleep 15

docker ps | grep openremote

printf "\n${CR}Openremote setup - verify - end${NC}"
printf "\n${CR}Openremote setup - end${NC}\n"
