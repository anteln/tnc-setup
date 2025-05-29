#!/bin/bash

CR='\033[0;35m'
NC='\033[0m'

printf "\n${CR}Basic setup - start${NC}"
printf "\n${CR}Basic setup - package - start${NC}\n\n"

apt update
apt install less nano curl jq -y

printf "\n${CR}Basic setup - package - end${NC}"
printf "\n${CR}Basic setup - configuration - start${NC}\n\n"

GATEWAY=$(jq -r .gateway config.json)
ADDRESS=$(jq -r .hosts.\"$1\".address config.json)
MASK=$(jq -r .mask config.json)

printf "\n${CR}Basic setup - configuration - end${NC}"
printf "\n${CR}Basic setup - network - start${NC}\n\n"

echo \
"[Match]
Name=eth0

[Network]
DHCP=no
DNS=9.9.9.9 1.1.1.1
Domains=local
IPv6PrivacyExtensions=false

Gateway=$GATEWAY
Address=$ADDRESS/$MASK" | \
tee /etc/systemd/network/eth0.network > /dev/null

sleep 1

networkctl reload

sleep 5

printf "\n${CR}Basic setup - network - end${NC}"
printf "\n${CR}Basic setup - end${NC}\n"
