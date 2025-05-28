#!/bin/bash

./basics.sh $1 $2 $3

./docker.sh

printf "\nNebula setup - start"
printf "\nNebula setup - folder - start\n\n"

mkdir -p /opt/stacks/nebula-sync
chmod 775 /opt/stacks/nebula-sync

printf "\nDocker setup - folder - end"
printf "\nDocker setup - configuration - start\n\n"

cp opt/stacks/nebula-sync/compose.yaml /opt/stacks/nebula-sync/compose.yaml
cp opt/stacks/nebula-sync/.env /opt/stacks/nebula-sync/.env

sed -i '' "s|host1|$4|g" /opt/stacks/nebula-sync/.env
sed -i '' "s|host2|$5|g" /opt/stacks/nebula-sync/.env

printf "\nDocker setup - configuration - end"
printf "\nDocker setup - run - start\n\n"

cd /opt/stacks/nebula-sync/

docker compose up -d

printf "\nDocker setup - run - end"
printf "\nDocker setup - verify - start\n\n"

docker ps | grep nebula

printf "\nDocker setup - verify - end"
printf "\nNebula setup - end\n"
