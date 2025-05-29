#!/bin/bash

CR='\033[0;35m'
NC='\033[0m'

printf "\n${CR}Docker setup - start${NC}"
printf "\n${CR}Docker setup - certificate - start${NC}\n\n"

apt update
apt install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

printf "\n${CR}Docker setup - certificate - end${NC}"
printf "\n${CR}Docker setup - repository - start${NC}\n\n"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

printf "\n${CR}Docker setup - repository - end${NC}"
printf "\n${CR}Docker setup - package - start${NC}\n\n"

apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

printf "\n${CR}Docker setup - package - end${NC}"
printf "\n${CR}Docker setup - test - start${NC}\n\n"

docker run hello-world

printf "\n${CR}Docker setup - test - end${NC}"
printf "\n${CR}Docker setup - end${NC}\n"
