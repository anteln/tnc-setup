# TrueNAS container setup

./pihole_install.sh gateway address mask
./nebula_install.sh gateway address mask pihole1 pihole2
./traefik_install.sh gateway address mask domain email apitoken

## Information

Create container instances running Debian Bookworm.
Setup with two (2) virtual CPU and 4096 MByte of RAM.
Use a pre-existing bridge.

## Blocklists

A good source for blocklists can be found here: <https://github.com/hagezi/>

## How to use

apt update
apt upgrade

apt install git -y

git clone <https://github.com/anteln/tnc-setup.git>

cd tnc-setup

Host: pihole-1.local:
./pihole_install.sh 192.168.1.1 192.168.1.61 24

Host: pihole-2.local:
./pihole_install.sh 192.168.1.1 192.168.1.62 24

Host: nebula-1.local:
./nebula_install.sh 192.168.1.1 192.168.1.71 24 192.168.1.61 192.168.1.62

Host: traefik-1.local:
./traefik_install.sh 192.168.1.1 192.168.1.81 24 local.domain <admin@test.com> apitoken
