all: ~/.learning-git/python3-modules html

~/.learning-git/python3-modules:
	mkdir -p ~/.learning-git/python3-modules
	docker run -it --rm -v ~/.learning-git/python3-modules:/tmp/site-packages python cp -R /usr/local/lib/python3.8/site-packages /tmp
	docker run -it --rm -v ~/.learning-git/python3-modules:/usr/local/lib/python3.8/site-packages python pip install -q pexpect==4.8.0 Jinja2==2.11.1
	docker run -it --rm -v $(shell pwd):/app -v ~/.learning-git/python3-modules:/usr/local/lib/python3.8/site-packages python ls /app

html:
	mkdir html

clean:
	rm -rf ~/.learning-git
	rm -rf html

