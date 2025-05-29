#!/bin/bash

./basics.sh $1

CR='\033[0;35m'
NC='\033[0m'

printf "\n${CR}Pihole setup - start${NC}"
printf "\n${CR}Pihole setup - package - start${NC}\n\n"

apt install python3-full python3-pip -y

printf "\n${CR}Pihole setup - package - end${NC}"
printf "\n${CR}Pihole setup - access - start${NC}\n\n"

groupadd pihole
useradd -g pihole -d /home/pihole -s /usr/sbin/nologin pihole

printf "\n${CR}Pihole setup - access - end${NC}"
printf "\n${CR}Pihole setup - configuration - start${NC}\n\n"

mkdir /etc/pihole
chmod 775 /etc/pihole
chown pihole:pihole /etc/pihole

cp etc/pihole/pihole.toml /etc/pihole/pihole.toml
chmod 644 /etc/pihole/pihole.toml
chown pihole:pihole /etc/pihole/pihole.toml

printf "\n${CR}Pihole setup - configuration - end${NC}"
printf "\n${CR}Pihole setup - install - start${NC}\n\n"

curl -sSL https://install.pi-hole.net | bash /dev/stdin --unattended

printf "\n${CR}Pihole setup - install - end${NC}"
printf "\n${CR}Pihole setup - update - start${NC}\n\n"

pihole -g

printf "\n${CR}Pihole setup - update - end${NC}"
printf "\n${CR}Pihole setup - configure - start${NC}\n\n"

python3 -m venv venv
venv/bin/pip install pihole6api
venv/bin/python3 pihole_config.py $1

printf "\n${CR}Pihole setup - configure - end${NC}"
printf "\n${CR}Pihole setup - update - start${NC}\n\n"

pihole -g

printf "\n${CR}Pihole setup - update - end${NC}"
printf "\n${CR}Pihole setup - end${NC}\n"
