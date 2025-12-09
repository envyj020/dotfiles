MAKEFLAGS += --silent

RED := \033[1;31m
GREEN := \033[1;32m
BLUE := \033[1;36m
NC := \033[0m

all: help

help:
	grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "$(BLUE)%-30s$(NC) %s\n", $$1, $$2}'

init:
	git submodule init
	git submodule update
	git lfs pull

.PHONY: init

base: init ## Installs base OS packages
	bin/install

.PHONY: base

mise: stow ## Installs system-wide mise packages
	mise install
	ya pkg install

.PHONY: mise

stow-check:
	command -v stow &>/dev/null || { \
		echo -e "$(RED)stow not found in your PATH, either install it or run$(NC) $(GREEN)make base$(NC)"; \
		exit 1; \
	}

.PHONY: stow-check

stow: stow-check init ## Symlinks dotfiles
	stow home -t $(HOME)
	stow config -t $(HOME)/.config

.PHONY: stow

unstow: stow-check ## Removes dotfiles symlinks
	stow -D home -t $(HOME)
	stow -D config -t $(HOME)/.config

.PHONY: stow
