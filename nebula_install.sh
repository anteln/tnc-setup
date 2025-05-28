#!/bin/bash

./basics.sh $1 $2 $3

./docker.sh

printf "\nNebula setup - start"
printf "\nNebula setup - folder - start\n\n"

mkdir -p /opt/stacks/nebula-sync
chmod 775 /opt/stacks/nebula-sync

printf "\nNebula setup - folder - end"
printf "\nNebula setup - configuration - start\n\n"

cp opt/stacks/nebula-sync/compose.yaml /opt/stacks/nebula-sync/compose.yaml
cp opt/stacks/nebula-sync/.env /opt/stacks/nebula-sync/.env

cd /opt/stacks/nebula-sync/

sed -i "s|host1|$4|g" .env
sed -i "s|host2|$5|g" .env

printf "\nNebula setup - configuration - end"
printf "\nNebula setup - run - start\n\n"

docker compose up -d

printf "\nNebula setup - run - end"
printf "\nNebula setup - verify - start\n\n"

sleep 15

docker ps | grep nebula

printf "\nNebula setup - verify - end"
printf "\nNebula setup - end\n"
