#!/bin/bash

./basics.sh $1 $2

groupadd pihole
useradd -g pihole -d /home/pihole -s /usr/sbin/nologin pihole

mkdir /etc/pihole
chmod 775 /etc/pihole
chown pihole:pihole /etc/pihole

cp pihole.toml /etc/pihole/pihole.toml
chmod 644 /etc/pihole/pihole.toml
chown pihole:pihole /etc/pihole/pihole.toml

curl -sSL https://install.pi-hole.net | bash /dev/stdin --unattended

pihole -g
