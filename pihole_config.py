import json
import argparse

import pihole6api

def clear_lists(client: pihole6api.PiHole6Client):
  lists = client.list_management.get_lists()
  for list in lists["lists"]:
    client.list_management.delete_list(list["address"], list["type"])

def add_lists(client: pihole6api.PiHole6Client):
  for list in data["lists"]:
    client.list_management.add_list(list["address"], list["type"])

def set_domain(client: pihole6api.PiHole6Client):
  config_changes = {}
  config_changes["dns"] = {}
  config_changes["dns"]["domain"] = data["domain"]

  client.config.update_config(config_changes)

def clear_hosts(client: pihole6api.PiHole6Client):
  config = client.config.get_config()
  host: str
  for host in config["config"]["dns"]["hosts"]:
    address, hostname = host.split()
    client.config.remove_local_a_record(hostname, address)

def add_hosts(client: pihole6api.PiHole6Client):
  for name, values in data["hosts"]:
    client.config.add_local_a_record(".".join((name, data["domain"])), values["reverse"])

if __name__ == "__main__":
  parser = argparse.ArgumentParser(prog="pihole_config", description="updates pihole configuration")
  parser.add_argument("host", action="store", help="the host to configure")

  args = parser.parse_args()

  with open("./config.json", "r") as jsonfile:
    data = json.load(jsonfile)

  client = pihole6api.PiHole6Client("https://{}/".format(data["hosts"][args.host]["address"]), "vk7COCiOSOuL4cvpvl9i/ccWoGV5zfUpWoib1KB5qvs=")

  clear_lists(client)
  add_lists(client)

  set_domain(client)

  clear_hosts(client)
  add_hosts(client)
