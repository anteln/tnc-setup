#!/bin/bash

apt update
apt upgrade -y

apt install git nano -y

git clone https://github.com/anteln/tnc-setup.git
