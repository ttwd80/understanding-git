all: ~/.learning-git/python3-modules ~/.learning-git/ruby-bundle html

~/.learning-git/python3-modules:
	mkdir -p ~/.learning-git/python3-modules
	docker run -it --rm -v ~/.learning-git/python3-modules:/tmp/site-packages python cp -R /usr/local/lib/python3.8/site-packages /tmp
	docker run -it --rm -v ~/.learning-git/python3-modules:/usr/local/lib/python3.8/site-packages python pip install -q pexpect==4.8.0 Jinja2==2.11.1
	docker run -it --rm -v $(shell pwd):/app -v ~/.learning-git/python3-modules:/usr/local/lib/python3.8/site-packages python ls /app

~/.learning-git/ruby-bundle:
	mkdir -p ~/.learning-git/ruby-bundle
	docker run -it --rm -v ~/.learning-git/ruby-bundle:/tmp/bundle ruby cp -R /usr/local/bundle /tmp
	docker run -it --rm -v ~/.learning-git/ruby-bundle:/usr/local/bundle ruby gem install haml -v 5.1.2

html:
	mkdir html

clean:
	rm -rf ~/.learning-git/python3-modules
	rm -rf ~/.learning-git/ruby-bundle
	rm -rf html

