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

for line in content_array:
    line = line.rstrip("\n")
    if len(line) > 1:
        c = line[0]
        if (c == '<'):
            child.expect(line[1:])
        elif (c == '>'):
            child.sendline(line[1:])
        else:
            print("Unknown command: {0}".format(c))
