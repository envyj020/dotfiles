MAKEFLAGS += --silent

RED := \033[1;31m
GREEN := \033[1;32m
BLUE := \033[1;36m
NC := \033[0m

cmd_exists = command -v $(1) >/dev/null 2>&1 || (echo -e "$(RED)$(1) not found$(NC). Run $(GREEN)make base$(NC)" && exit 1)

all: help

help:
	grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "$(BLUE)%-30s$(NC) %s\n", $$1, $$2}'

.PHONY: help

init:
	git submodule update --init --recursive
	git lfs pull

.PHONY: init

base: init ## Install base OS packages
	bin/install

.PHONY: base

mise: x-stow x-mise ## Install mise packages
	stow pkg -t $(HOME)/.config
	mise install
	ya pkg install

.PHONY: mise

stow: x-stow init ## Symlinks dotfiles
	stow home -t $(HOME)
	stow config -t $(HOME)/.config
	stow pkg -t $(HOME)/.config

.PHONY: stow

unstow: x-stow ## Remove dotfiles symlinks
	stow -D home -t $(HOME)
	stow -D config -t $(HOME)/.config
	stow -D pkg -t $(HOME)/.config

.PHONY: unstow

x-stow:
	$(call cmd_exists,stow)

.PHONY: x-stow

x-mise:
	$(call cmd_exists,mise)

.PHONY: x-mise
