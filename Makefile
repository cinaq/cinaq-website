OS := $(shell uname)
OS_NAME := Unsupported
ifeq ($(OS),Darwin)
	OS_NAME := macOS
endif
ifeq ($(OS),Linux)
	OS_NAME := Linux
endif

HUGO_VERSION := 0.82.0

HUGO_URL := https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_$(OS_NAME)-64bit.tar.gz
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

tools/hugo:
	curl -L -o tools/hugo.tar.gz $(HUGO_URL)
	tar -xvf tools/hugo.tar.gz -C tools hugo
	rm tools/hugo.tar.gz

tools/plantuml.jar:
	curl -L -o tools/plantuml.jar $(PLANTUML_URL)

clean:
	rm tools/*
