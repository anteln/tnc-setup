#!/bin/bash

apt update
apt upgrade

apt install less nano curl python3 -y

echo \
"[Match]
Name=eth0

[Network]
DHCP=no
DNS=9.9.9.9 1.1.1.1
Domains=local
IPv6PrivacyExtensions=false

Gateway=$1
Address=$2" | \
tee /etc/systemd/network/eth0.network > /dev/null
