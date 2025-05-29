#!/bin/bash

./basics.sh $1

printf "\nPihole setup - start"
printf "\nPihole setup - package - start\n\n"

apt install python3-full python3-pip -y

printf "\nPihole setup - package - end"
printf "\nPihole setup - access - start\n\n"

groupadd pihole
useradd -g pihole -d /home/pihole -s /usr/sbin/nologin pihole

printf "\nPihole setup - access - end"
printf "\nPihole setup - configuration - start\n\n"

mkdir /etc/pihole
chmod 775 /etc/pihole
chown pihole:pihole /etc/pihole

cp etc/pihole/pihole.toml /etc/pihole/pihole.toml
chmod 644 /etc/pihole/pihole.toml
chown pihole:pihole /etc/pihole/pihole.toml

printf "\nPihole setup - configuration - end"
printf "\nPihole setup - install - start\n\n"

curl -sSL https://install.pi-hole.net | bash /dev/stdin --unattended

printf "\nPihole setup - install - end"
printf "\nPihole setup - update - start\n\n"

pihole -g

printf "\nPihole setup - update - end"
printf "\nPihole setup - configure - start\n\n"

python3 -m venv venv
venv/bin/pip install pihole6api
venv/bin/python3 pihole_config.py $1

printf "\nPihole setup - configure - end"
printf "\nPihole setup - update - start\n\n"

pihole -g

printf "\nPihole setup - update - end"
printf "\nPihole setup - end\n"
