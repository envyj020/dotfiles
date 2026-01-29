MAKEFLAGS += --silent
SHELL := /bin/bash

XDG_BIN_HOME := $(HOME)/.local/bin
PATH := $(XDG_BIN_HOME):$(PATH)

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
	git lfs pull -I 'static/*' >/dev/null

.PHONY: init

base: ## Install base OS packages
	bin/install

.PHONY: base

bootstrap: init stow ## Bootstrap mise and neovim dependencies
	bin/bootstrap

.PHONY: bootstrap

stow: init ## Symlinks dotfiles
	stow home -t $(HOME)
	stow config -t $(HOME)/.config

.PHONY: stow

unstow: ## Remove dotfiles symlinks
	stow -D home -t $(HOME)
	stow -D config -t $(HOME)/.config

.PHONY: unstow
