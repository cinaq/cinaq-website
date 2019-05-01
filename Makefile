OS := $(shell uname)
OS_NAME := Unsupported
ifeq ($(OS),Darwin)
	OS_NAME := macOS
endif
ifeq ($(OS),Linux)
	OS_NAME := Linux
endif

HUGO_URL := https://github.com/gohugoio/hugo/releases/download/v0.52/hugo_0.52_$(OS_NAME)-64bit.tar.gz
PLANTUML_URL := https://kent.dl.sourceforge.net/project/plantuml/1.2019.5/plantuml.1.2019.5.jar
PLANTUML := java -jar tools/plantuml.jar

DIAGRAMS_DIR := static/media/diagrams
DIAGRAMS_SRC := $(wildcard $(DIAGRAMS_DIR)/*.plantuml)
DIAGRAMS_PNG := $(addsuffix .png, $(basename $(DIAGRAMS_SRC)))


all: dev

dev: tools/hugo artifacts
	./tools/hugo server

artifacts: $(DIAGRAMS_PNG)

$(DIAGRAMS_DIR)/%.png: $(DIAGRAMS_DIR)/%.plantuml
	$(PLANTUML) -tpng $<

build: tools/hugo public artifacts
	cd public && git fetch
	cd public && git checkout -b gh-pages || true
	cd public && git reset --hard origin/gh-pages
	./tools/hugo
	cd public && git add . && git diff --staged || true

publish: build
	cd public && git commit -m "Publish" && git push origin gh-pages

tools/hugo:
	curl -L -o tools/hugo.tar.gz $(HUGO_URL)
	tar -xvf tools/hugo.tar.gz -C tools hugo
	rm tools/hugo.tar.gz

tools/plantuml.jar:
	curl -L -o tools/plantuml.jar $(PLANTUML_URL)

public:
	git clone git@github.com:cinaq/cinaq-website.git -b gh-pages public

clean:
	rm tools/*
