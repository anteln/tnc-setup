# TrueNAS container setup

## Information

Create container instances running Debian Bookworm.\
Setup with two (2) virtual CPU and 4096 MByte of RAM.\
Use a pre-existing bridge.\
\
The hostnames are used for direct access to services\
hosted (for example, a Samba share from a NAS) while the\
host aliases are used for the secure websites for the\
services (for example, a NAS management UI).

## Blocklists

Good sources for blocklists can be found here:

* <https://github.com/hagezi/>
* <https://firebog.net/>

## How to use

First edit config.json to match the infrastucture and environment.\
Note: the same config.json should be used for all install commands.\
\
`apt update; apt install curl -y; curl https://raw.githubusercontent.com/anteln/tnc-setup/refs/heads/master/init.sh -o init.sh; chmod 755 init.sh; ./init.sh; cd tnc-setup`\
\
`./pihole_install.sh ns-1`\
`./pihole_install.sh ns-2`\
`./nebula_install.sh nebula-1`\
`./traefik_install.sh traefik-1`\
`./openremote_install.sh or-1`\
\
In order to only update the pihole configuration use below commands.\
\
`python3 -m venv venv`\
`venv/bin/pip install pihole6api`\
`venv/bin/python3 pihole_config.py ns-1`\
\
In order to find occupied addresses run the below command in powershell.\
Note: only works for the addresses occupied by services reponding to ping.\
\
`1..100 | ForEach-Object { Test-Connection -Count 1 192.168.1.$_ -ErrorAction SilentlyContinue | Select-Object -First 1 }`
