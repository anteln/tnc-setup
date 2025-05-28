#!/bin/bash

printf "\nDocker setup - start"
printf "\nDocker setup - certificate - start\n\n"

# Add Docker's official GPG key:
apt update
apt install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

printf "\nDocker setup - certificate - end"
printf "\nDocker setup - repository - start\n\n"

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

printf "\nDocker setup - repository - end"
printf "\nDocker setup - package - start\n\n"

# Install and test the docker installation
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

printf "\nDocker setup - package - end"
printf "\nDocker setup - test - start\n\n"

docker run hello-world

printf "\nDocker setup - test - end"
printf "\nDocker setup - end\n"
