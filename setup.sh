#!/bin/bash

Docker:

# Add Docker's official GPG key:
apt update
apt install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# Install and test the docker installation
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
docker run hello-world



NGINX Proxy Manager:

nano npm/docker-compose.yml

services:
  nginx-proxy:
    image: 'jc21/nginx-proxy-manager:2.12.3'
    container_name: nginx-proxy
    ports:
      - '80:80'
      - '443:443'
      - '81:81'
    environment:
      DB_MYSQL_HOST: "mariadb"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "npm"
      DB_MYSQL_PASSWORD: "SH6SJKH!jd875sdj"
      DB_MYSQL_NAME: "npm"
      DISABLE_IPV6: 'true'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    depends_on:
      - mariadb
    networks:
      - frontend
    restart: unless-stopped

  mariadb:
    image: 'jc21/mariadb-aria:latest'
    container_name: nginx-proxy-database
    environment:
      MYSQL_ROOT_PASSWORD: 'SH6SJKH!jd875sdj'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'SH6SJKH!jd875sdj'
      MARIADB_AUTO_UPGRADE: '1'
    volumes:
      - ./mysql:/var/lib/mysql
    networks:
      - frontend
    restart: unless-stopped

networks:
   frontend:
     driver: bridge
