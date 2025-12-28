MAKEFLAGS += --silent

RED := \033[1;31m
GREEN := \033[1;32m
BLUE := \033[1;36m
NC := \033[0m

all: help

help:
	grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "$(BLUE)%-30s$(NC) %s\n", $$1, $$2}'

.PHONY: help

init:
	git submodule update --init --recursive
	git lfs pull

.PHONY: init

base: init ## Installs base OS packages
	bin/install

.PHONY: base

mise: stow ## Installs system-wide mise packages
	mise install
	ya pkg install

.PHONY: mise

x-stow:
	command -v stow > /dev/null 2>&1 || { \
		printf "$(RED)stow not found, run $(GREEN)make base$(NC)\n"; \
		exit 1; \
	}

.PHONY: x-stow

stow: x-stow init ## Symlinks dotfiles
	stow home -t $(HOME)
	stow config -t $(HOME)/.config

.PHONY: stow

unstow: x-stow ## Removes dotfiles symlinks
	stow -D home -t $(HOME)
	stow -D config -t $(HOME)/.config

.PHONY: unstow
