from jinja2 import Environment, FileSystemLoader
import sys
import os
import re
import collections

command = sys.argv[1]
source = sys.argv[2]
examples = str(sys.argv[3]).split(",")


ansi_escape = re.compile(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]')
starts_with_lowercase = re.compile("^[a-z].*")

env = Environment(loader=FileSystemLoader("./template"))
data = {}

data['command'] = command

d = collections.OrderedDict()

lines = os.environ["TEMPLATE_GIT_HELP"].replace("\r", "").split("\n")


def strip_ansi(line):
    return ansi_escape.sub('', line)


last_used_key = ""
for line in lines:
    line = line.strip()
    if line:
        line = line.replace("|", "\|")
        if line.startswith("-"):
            words = line.split(" ")
            key = ""
            value = ""
            for i in range(1, len(words)):
                if starts_with_lowercase.match(words[i]):
                    key = " ".join(words[0: i - 1]).strip()
                    value = " ".join(words[i:]).strip()
                    break
            if key == "":
                key = " ".join(words)
            d[key] = value
            last_used_key = key
        else:
            d[last_used_key] = (d[last_used_key] + " " + line).strip()

data['items'] = d


data['example'] = {}
for example in examples:
    os_key = "TEMPLATE_GIT_EXAMPLE_{0}".format(example)
    if example:
        lines = os.environ[os_key].replace("\r", "").split("\n")
        lines = [strip_ansi(line) for line in lines]
        data['example'][example] = lines

template = env.get_template(source)
print(template.render(data))
