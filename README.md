# TrueNAS container setup

## Information

Create container instances running Debian Bookworm.\
Setup with two (2) virtual CPU and 4096 MByte of RAM.\
Use a pre-existing bridge.\
Note: Do NOT use default network settings!\
\
The hostnames are used for direct access to services\
hosted (for example, a Samba share from a NAS) while\
the host aliases are used for the secure websites for\
the services (for example, a NAS management UI).

## Blocklists

Good sources for blocklists can be found here:

* <https://github.com/hagezi/>
* <https://firebog.net/>

## How to use

Save a copy of the configuration file to a local file which can be\
used as a master for all deployments. Edit config.json to match the\
infrastucture and environment.\
Note: the same config.json should be used for all install commands.\
\
The file can be downloaded from:\
\
`https://raw.githubusercontent.com/anteln/tnc-setup/refs/heads/master/config.json`\
\
Next execute the commands for setting up and starting the services.\
Note: Make sure the host has an internet connection before this.\
\
`apt update; apt install curl -y; curl https://raw.githubusercontent.com/anteln/tnc-setup/refs/heads/master/init.sh -o init.sh; chmod 755 init.sh; ./init.sh; cd tnc-setup`\
\
`nano config.json`\
\
The recommended order of deployment is according to the command list below:\
\
`./pihole_install.sh`\
`./nebula_install.sh`\
`./traefik_install.sh`\
`./openremote_install.sh`\
\
Each shell script above can be run with a parameter specifying the\
hostname or without. If used without the hostname parameter (which\
is the recommended way) the script will retrieve the current\
hostname instead.\
\
The recommended virtual hosts can be found in the configuration file,\
but as a short summary:\
\
ns-1, ns-2, nebula-1, traefik-1 and or-1\
\
In order to only update the pihole configuration use the commands below.\
\
`python3 -m venv venv`\
`venv/bin/pip install pihole6api`\
`venv/bin/python3 pihole_config.py ns-1`\
\
In order to find occupied addresses run the below command in powershell.\
Note: only works for the addresses occupied by services reponding to ping.\
\
`1..100 | ForEach-Object { Test-Connection -Count 1 192.168.1.$_ -ErrorAction SilentlyContinue | Select-Object -First 1 }`
