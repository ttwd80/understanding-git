from jinja2 import Environment, FileSystemLoader
import sys
import os
import collections

source = sys.argv[1]
example_count = int(sys.argv[2])

env = Environment(loader=FileSystemLoader("./template"))
data = {}
data['example'] = {}
for i in range(1, example_count + 1):
    os_key = "TEMPLATE_GIT_EXAMPLE_{0}".format(i)
    data['example'][str(i)] = os.environ[os_key].replace("\r", "").split("\n")


template = env.get_template(source)
print(template.render(data))
