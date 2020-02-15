from jinja2 import Environment, FileSystemLoader
import sys
import os

source = sys.argv[1]
names = sys.argv[2].split(",")

env = Environment(loader=FileSystemLoader("./template"))
data = {}
for name in names:
    if name.startswith("TEMPLATE_MULTIPLE_"):
        data[name.replace("TEMPLATE_MULTIPLE_", "").lower()] = os.environ[name].split("\n")
    elif name.startswith("TEMPLATE_SINGLE_"):
        data[name.replace("TEMPLATE_SINGLE_", "").lower()] = os.environ[name]
    else:
        print("Unknown value - {0}".format(name))
    
print(data)
template = env.get_template(source)
print(template.render(data))