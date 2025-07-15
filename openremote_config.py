import json
import argparse

def generate_compose():
  with open("./opt/stacks/openremote/compose.yaml", "r") as composefile:
    contents = composefile.read().replace("HOSTNAME", data["hosts"][args.host]["address"]).replace("SSL_PORT", "443").replace("PASSWORD", "calvin")
  with open("./opt/stacks/openremote/compose.yaml", "w") as composefile:
    composefile.write(contents)

if __name__ == "__main__":
  parser = argparse.ArgumentParser(prog="openremote_config", description="updates openremote configuration")
  parser.add_argument("host", action="store", help="the host to configure")

  args = parser.parse_args()

  with open("./config.json", "r") as jsonfile:
    data = json.load(jsonfile)

  generate_compose()
