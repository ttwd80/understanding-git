import pexpect
import sys
child = pexpect.spawn('docker run --rm -it gitlab/gitlab-ce /bin/bash', encoding='utf-8')
child.logfile_read=sys.stdout
child.expect(':/# $')
child.sendline('git --version')
child.expect(':/# $')
child.sendline('exit')
child.expect(pexpect.EOF)
