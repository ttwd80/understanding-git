from jinja2 import Template
import os
with open('templates/intro.html.j2') as f:
    tmpl = Template(f.read())
data = {"git_version" : os.environ['GIT_VERSION']}
print (tmpl.render(data))
