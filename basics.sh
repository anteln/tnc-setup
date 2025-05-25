#!/bin/bash

printf "\nBasic setup - start"
printf "\nBasic setup - package - start\n\n"

apt update
apt install less nano curl -y

printf "\nBasic setup - package - end"
printf "\nBasic setup - network - start\n\n"

echo \
"[Match]
Name=eth0

[Network]
DHCP=no
DNS=9.9.9.9 1.1.1.1
Domains=local
IPv6PrivacyExtensions=false

Gateway=$1
Address=$2/$3" | \
tee /etc/systemd/network/eth0.network > /dev/null

systemctl restart networking

Sleep 30

printf "\nBasic setup - network - end"
printf "\nBasic setup - end\n
