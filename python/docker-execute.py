import pexpect
import sys


session_file = sys.argv[1]
docker_image = sys.argv[2]
command_to_run = sys.argv[3]

content_array = []
with open(session_file) as f:
    for line in f:
        content_array.append(line)

child = pexpect.spawn(
    "docker run --rm -it {0} {1}".format(docker_image, command_to_run), encoding='utf-8')
child.logfile_read = sys.stdout
child.setecho(False)
child.expect("<\\$ $")

for line in content_array:
    line = line.rstrip("\n")
    if ((len(line) > 0) and (line[0] != "#")):
        child.sendline(line)
        child.expect("<\\$ $")
