OS ?= darwin ## OS we're building for (e.g. linux)
ARCH ?= amd64 ## Arch we're building for  (e.g. amd64)
VERSION ?= master ## Version we're releasing
INSTALL_PATH ?= /usr/local/bin

GOOS = $(strip $(OS))
GOARCH = $(strip $(ARCH))
V = $(strip $(VERSION))
P = $(strip $(INSTALL_PATH))

BUILD_PATH = ./build/bin/$(GOOS)/$(GOARCH)
ARTIFACT_PATH = ./build/artifacts

export GO_BUILD=GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(BUILD_PATH)/temple ./
export TAR=tar -czvf $(ARTIFACT_PATH)/temple-$(V)-$(GOOS)-$(GOARCH).tar.gz -C $(BUILD_PATH) temple
export EXAMPLE_COMMAND=temple --file ./example.tpl app=temple flag=--file key=value

build: setup ## Build temple binary
	$(GO_BUILD)

setup: ## Setup build/artifact paths.
	mkdir -p $(BUILD_PATH)
	mkdir -p $(ARTIFACT_PATH)

clean: ## Cleanup build dir
	 rm -rf ./build/*

build-all: ## Build binaries for linux and macOS
	OS="darwin" ARCH="amd64" make build
	OS="linux" ARCH="amd64" make build

build-artifact: setup ## Build binary and create release artifact
	$(GO_BUILD)
	$(TAR)

release: ## Build binaries and create release artifactors for both linux and macOS
	OS="darwin" ARCH="amd64" make build-artifact
	OS="linux" ARCH="amd64" make build-artifact

install: ## Build binary and install to the specified install path (default /usr/local/bin)
	$(GO_BUILD)
	cp $(BUILD_PATH)/temple $(P)/temple

readme: install ## Uses temple itself to generate the README.md for this project
	temple --file README.md.tpl usage="`temple --help`" exampleCommand="$(EXAMPLE_COMMAND)" exampleOut="`$(EXAMPLE_COMMAND)`" > README.md

help: ## Print Makefile help
	@echo "Makefile for temple"
	@echo "#### Examples ####"
	@echo "Build a linux binary:"
	@echo "   OS=linux make build"
	@echo "Build both linux and macOS binaries and create release artifacts:"
	@echo "   VERSION=v0.1.0 make release"
	@echo "#### Environment Variables ####"
	@awk '$$4 == "##" {gsub(/\?=./, "", $$0); $$2="(default: "$$2")"; printf "-- %s \n", $$0}' Makefile
	@echo "#### Targets ####"
	@awk '$$1 ~ /^.*:$$/ {gsub(":", "", $$1);printf "-- %s \n", $$0}' Makefile
