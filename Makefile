all:
	hugo
hugo:
	curl -L -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.52/hugo_0.52_Linux-64bit.tar.gz
	tar -xvf hugo.tar.gz hugo
	rm hugo.tar.gz
