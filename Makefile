MAKEFLAGS += --silent
SHELL := /bin/bash

NVM_DIR = $(HOME)/.nvm/nvm.sh
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_DATA_HOME := $(HOME)/.local/share

PATH := $(XDG_BIN_HOME):$(PATH)
PATH := $(XDG_DATA_HOME)/bob/nvim-bin:$(PATH)

RED := \033[1;31m
GREEN := \033[1;32m
BLUE := \033[1;36m
NC := \033[0m

define CMD_EXISTS
	if ! command -v $(1) >/dev/null 2>&1; then
		echo -e "$(RED)$(1) not found$(NC). Run $(GREEN)make base$(NC)"
		exit 1
	fi
endef

define FILE_EXISTS
	if [[ ! -f $(1) ]]; then
		echo -e "$(RED)$(1) not found$(NC). Run $(GREEN)make base$(NC)"
		exit 1
	fi
endef

all: help

help:
	grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "$(BLUE)%-30s$(NC) %s\n", $$1, $$2}'

.PHONY: help

init:
	git submodule update --init --recursive
	git lfs pull -I 'static/*' >/dev/null

.PHONY: init

base: init ## Install base OS packages
	bin/install

.PHONY: base

.ONESHELL:
mise: f-nvm x-mise stow ## Install mise packages
	set -e
	source $(NVM_DIR)
	mise install &>/dev/null
	eval "$$(mise activate bash)"
	ya pkg install &>/dev/null

.PHONY: mise

neovim: x-neovim stow ## Install Neovim dependencies
	nvim --headless "+PlugInstall --sync" +qa &>/dev/null
	nvim --headless "+TSUpdateSync" +qa &>/dev/null
	nvim --headless "+MasonToolsInstallSync" +qa &>/dev/null

stow: x-stow init ## Symlinks dotfiles
	stow home -t $(HOME)
	stow config -t $(HOME)/.config

.PHONY: stow

unstow: x-stow ## Remove dotfiles symlinks
	stow -D home -t $(HOME)
	stow -D config -t $(HOME)/.config

.PHONY: unstow

x-stow:
	$(call CMD_EXISTS,stow)

.PHONY: x-stow

x-mise:
	$(call CMD_EXISTS,mise)

.PHONY: x-mise

x-neovim:
	$(call CMD_EXISTS,nvim)

.PHONY: x-neovim

f-nvm:
	$(call FILE_EXISTS,$(NVM_DIR))

.PHONY: f-nvm
