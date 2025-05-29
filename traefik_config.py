import json
import argparse

import jinja2

if __name__ == "__main__":
  parser = argparse.ArgumentParser(prog="traefik_config", description="updates traefik configuration")
  parser.add_argument("host", action="store", help="the host to configure")

  args = parser.parse_args()

  with open("./config.json", "r") as jsonfile:
    data = json.load(jsonfile)

  routers = {}
  services = {}
  middlewares = {}

  env = jinja2.Environment(loader=jinja2.PackageLoader("traefik_config", "templates"))
  template = env.get_template("config.yml.j2")
  print(template.render(routers, services, middlewares))

# url = f"{protocol}://{name}.{domain}:{port}"
