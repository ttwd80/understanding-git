from jinja2 import Environment, FileSystemLoader
import sys
import os
import collections
import re

source = sys.argv[1]
name = sys.argv[2]
number = int(sys.argv[3])
title = sys.argv[4]

env = Environment(loader=FileSystemLoader("./template"))
lines = os.environ[name].replace("\r", "").split("\n")
d = collections.OrderedDict()
interested = False
for line in lines:
    # print("{0}:{1}".format(len(line), line))
    if interested:
        if len(line) == 0:
            break
        words = line.split(" ")
        words = [var for var in words if var]
        d[words[0]] = " ".join(words[1:])
    if line == title:
        interested = True

data = {}
data['items'] = d
data['section'] = {'number': number, 'title': title}
template = env.get_template(source)
print(template.render(data))
