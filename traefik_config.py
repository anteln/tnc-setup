import json
import argparse

import jinja2

def generate_config():
  config = { "routers": [], "services": [], "middlewares": [] }
  for name, values in data["hosts"].items():
    if "config" in values.keys():
      protocol = data["services"][values["config"]]["protocol"]
      port = data["services"][values["config"]]["port"]
      config["routers"].append({ "name": values["alias"], "domain": data["domain"], "middlewares": data["routers"][values["config"]] })
      config["services"].append({ "name": values["alias"], "url": "{}://{}.{}:{}".format(protocol, name, data["domain"], port)})

  for name, values in data["middlewares"].items():
    config["middlewares"].append({ "name": name, "type": values["type"], "tag": values["tag"], "value": values["value"], "permanent": values["permanent"] })

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
  with open("./opt/stacks/traefik/data/traefik.yml", "r") as traefikfile:
    contents = traefikfile.read().replace("YOUREMAIL", data["email"])
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
