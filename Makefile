all: markdown python3-modules ruby-bundle

python3-modules:
	docker volume rm -f python-site-packages
	docker volume create python-site-packages
	docker run -it --rm -v python-site-packages:/usr/local/lib/python3.8/site-packages python pip install -q pexpect==4.8.0 Jinja2==2.11.1
	docker run -it --rm -v $(shell pwd):/app -v python-site-packages:/usr/local/lib/python3.8/site-packages python ls /app

ruby-bundle:
	docker volume rm -f ruby-bundle
	docker volume create ruby-bundle
	docker run -it --rm -v ruby-bundle:/usr/local/bundle ruby gem install haml -v 5.1.2

markdown:
	mkdir markdown

clean:
	rm -rf markdown

