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

def add_hosts(client: pihole6api.PiHole6Client):
  for host in data["hosts"]:
    client.config.add_local_a_record(".".join((host["name"], data["domain"])), host["address"])

if __name__ == "__main__":
  parser = argparse.ArgumentParser(prog="pihole_config", description="updates pihole configuration")
  parser.add_argument("address", action="store", help="runs the automatic check")

  args = parser.parse_args()

  client = pihole6api.PiHole6Client("https://{}/".format(args.address), "vk7COCiOSOuL4cvpvl9i/ccWoGV5zfUpWoib1KB5qvs=")

  with open("./pihole.json", "r") as jsonfile:
    data = json.load(jsonfile)

  clear_lists(client)
  add_lists(client)

  set_domain(client)

  add_hosts(client)
