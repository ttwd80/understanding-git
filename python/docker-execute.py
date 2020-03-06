import pexpect
import sys


session_file = sys.argv[1]
docker_image = sys.argv[2]
command_to_run = sys.argv[3]

content_array = []
with open(session_file) as f:
    for line in f:
        content_array.append(line)

expect_prompt = "\\$ $"
child = pexpect.spawn(
    "docker run --rm -it {0} {1}".format(docker_image, command_to_run), encoding='utf-8')
child.logfile_read = sys.stdout
child.setecho(False)
child.expect(expect_prompt)

for line in content_array:
    line = line.rstrip("\n")
    if len(line) == 1:
        if line == "$":
            expect_prompt = "\\$ $"
        elif line == "#":
            expect_prompt = "# $"
        else:
            sys.stderr.write("Unknown command [" + line + "]")
            exit(-1)

    if ((len(line) > 1) and (line[0] != "#")):
        child.sendline(line)
        child.expect(expect_prompt)
