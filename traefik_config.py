import json
import argparse

import jinja2

caserver = { "prod": "https://acme-v02.api.letsencrypt.org/directory", "test": "https://acme-staging-v02.api.letsencrypt.org/directory" }

def generate_config():
  config = { "routers": [], "services": [], "middlewares": [] }
  for name, values in data["hosts"].items():
    if "config" in values.keys():
      protocol = "https"
      port = 443
      if values["config"] in data["services"].keys():
        protocol = data["services"][values["config"]]["protocol"]
        port = data["services"][values["config"]]["port"]
      else:
        protocol = data["services"]["normal"]["protocol"]
        port = data["services"]["normal"]["port"]
      config["routers"].append({ "name": values["alias"], "domain": data["domain"], "middlewares": data["routers"][values["config"]] })
      if protocol == "http" and port == 80 or protocol == "https" and port == 443:
        config["services"].append({ "name": values["alias"], "url": "{}://{}".format(protocol, values["address"])})
      else:
        config["services"].append({ "name": values["alias"], "url": "{}://{}:{}".format(protocol, values["address"], port)})

  for name, values in data["middlewares"].items():
    rules = []
    for rule in values["rules"]:
      rules.append({ "tag": rule["tag"], "value": rule["value"] })
    config["middlewares"].append({ "name": name, "type": values["type"], "rules": rules, "permanent": values["permanent"] })

  env = jinja2.Environment(loader=jinja2.PackageLoader("traefik_config", "templates"))
  output = env.get_template("config.yml.j2").render(config) + "\n"

  with open("./opt/stacks/traefik/data/config.yml", "w") as configfile:
    configfile.write(output)

def generate_token():
  token = data["token"]
  with open("./opt/stacks/traefik/cf_api_token", "w") as tokenfile:
    tokenfile.write(token)

def generate_compose():
  with open("./opt/stacks/traefik/compose.yaml", "r") as composefile:
    contents = composefile.read().replace("LOCALDOMAIN", data["domain"])
  with open("./opt/stacks/traefik/compose.yaml", "w") as composefile:
    composefile.write(contents)

def generate_traefik():
  config = "test"
  if data["config"]["test"] and data["config"]["prod"]: pass
  if data["config"]["test"] and not data["config"]["prod"]: pass
  if not data["config"]["test"] and data["config"]["prod"]: config = "prod"
  if not data["config"]["test"] and not data["config"]["prod"]: pass
  with open("./opt/stacks/traefik/data/traefik.yml", "r") as traefikfile:
    contents = traefikfile.read().replace("YOUREMAIL", data["email"]).replace("CASERVER", caserver[config])
  with open("./opt/stacks/traefik/data/traefik.yml", "w") as traefikfile:
    traefikfile.write(contents)

if __name__ == "__main__":
  parser = argparse.ArgumentParser(prog="traefik_config", description="updates traefik configuration")
  parser.add_argument("host", action="store", help="the host to configure")

  args = parser.parse_args()

  with open("./config.json", "r") as jsonfile:
    data = json.load(jsonfile)

  generate_config()
  generate_token()
  generate_compose()
  generate_traefik()
