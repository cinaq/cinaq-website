OS := $(shell uname)
OS_NAME := Unsupported
OS_ARCH := 64bit
ifeq ($(OS),Darwin)
	OS_NAME := darwin
	OS_ARCH := universal
endif
ifeq ($(OS),Linux)
	OS_NAME := Linux
	OS_ARCH := 64bit
endif

HUGO_VERSION := 0.159.2

HUGO_ASSET_EXT := tar.gz
ifeq ($(OS),Darwin)
	HUGO_ASSET_EXT := pkg
endif

HUGO_URL := https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_$(OS_NAME)-$(OS_ARCH).$(HUGO_ASSET_EXT)
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
ifeq ($(OS),Darwin)
	curl -L -o tools/hugo.pkg $(HUGO_URL)
	rm -rf tools/hugo-pkg
	pkgutil --expand tools/hugo.pkg tools/hugo-pkg
	(cd tools && cat hugo-pkg/Payload | gunzip -dc | cpio -i "./hugo")
	chmod +x tools/hugo
	rm -rf tools/hugo.pkg tools/hugo-pkg
else
	curl -L -o tools/hugo.tar.gz $(HUGO_URL)
	tar -xvf tools/hugo.tar.gz -C tools hugo
	rm tools/hugo.tar.gz
endif

tools/plantuml.jar:
	curl -L -o tools/plantuml.jar $(PLANTUML_URL)

clean:
	rm tools/*
