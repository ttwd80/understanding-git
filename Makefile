all: ~/.learning-git/python3-modules

~/.learning-git/python3-modules:
	mkdir -p ~/.learning-git/python3-modules
	docker run -it --rm -v ~/.learning-git/python3-modules:/tmp/site-packages python cp -R /usr/local/lib/python3.8/site-packages /tmp
	docker run -it --rm -v ~/.learning-git/python3-modules:/usr/local/lib/python3.8/site-packages python pip list
	docker run -it --rm -v ~/.learning-git/python3-modules:/usr/local/lib/python3.8/site-packages python pip install pexpect==4.8.0
	#pip install pexpect==4.8.0
	echo "How?"

clean:
	rm -rf ~/.learning-git

