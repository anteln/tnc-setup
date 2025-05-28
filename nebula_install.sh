#!/bin/bash

./basics.sh $1 $2 $3

printf "\nNebula setup - start"

./docker.sh

mkdir /opt/stacks/nebula-sync
chmod 775 /opt/stacks/nebula-sync

cp opt/stacks/nebula-sync/compose.yaml /opt/stacks/nebula-sync/compose.yaml
cp opt/stacks/nebula-sync/.env /opt/stacks/nebula-sync/.env

sed -i '' "s|host1|$4|g" /opt/stacks/nebula-sync/.env
sed -i '' "s|host2|$5|g" /opt/stacks/nebula-sync/.env

cd /opt/stacks/nebula-sync/

docker compose up -d

docker ps | grep nebula

printf "\nNebula setup - end\n"
