DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := macos
HOMEBREW_PREFIX := /opt/homebrew
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)
SHELL := env PATH=$(PATH) /bin/zsh
export XDG_CONFIG_HOME=$(HOME)/.config
export DOTFILES_DIR

all: sudo core omz packages link bin-permissions macos-defaults

core: brew git npm

stow-mac: brew
	is-executable stow || brew install stow

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

omz: git
	[[ -f ~/.oh-my-zsh/oh-my-zsh.sh ]] || curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
	[[ -d ~/.oh-my-zsh/custom/plugins/fzf-tab ]] || git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab

packages: brew-packages cask-apps vscode-extensions

link: stow-mac
	for FILE in $$(\ls -A $(DOTFILES_DIR)/config); do \
		stow --dir=$(DOTFILES_DIR)/config --target=$(HOME) --verbose=1 --ignore='\.DS_Store' $$FILE; \
	done

bin-permissions:
	chmod +x $(DOTFILES_DIR)/bin/*

macos-defaults: bin-permissions packages
	@if [ "$$(uname)" = "Darwin" ]; then \
		dotfiles macos && dotfiles dock; \
	fi

unlink: stow-mac
	for FILE in $$(\ls -A $(DOTFILES_DIR)/config); do \
		stow --delete --dir=$(DOTFILES_DIR)/config --target=$(HOME) --verbose=1 $$FILE; \
	done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

git: brew
	brew install git

npm: brew-packages
	sudo n install lts

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

extra-cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Extracaskfile || true

vscode-extensions: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Codefile || true
