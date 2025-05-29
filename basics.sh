#!/bin/bash

printf "\nBasic setup - start"
printf "\nBasic setup - package - start\n\n"

apt update
apt install less nano curl jq -y

printf "\nBasic setup - package - end"
printf "\nBasic setup - configuration - start\n\n"

GATEWAY=$(jq -r .gateway config.json)
ADDRESS=$(jq -r .hosts.\"$1\".address config.json)
MASK=$(jq -r .mask config.json)

printf "\nBasic setup - configuration - end"
printf "\nBasic setup - network - start\n\n"

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

printf "\nBasic setup - network - end"
printf "\nBasic setup - end\n"
