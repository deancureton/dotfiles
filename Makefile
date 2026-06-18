DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := macos
HOMEBREW_PREFIX := /opt/homebrew
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)
SHELL := env PATH=$(PATH) /bin/zsh
export XDG_CONFIG_HOME=$(HOME)/.config
export DOTFILES_DIR

all: sudo core zsh-plugins packages link bin-permissions setup-passwordless-sudo macos-defaults

core: brew git node

stow-mac: brew
	is-executable stow || brew install stow

sudo:
	sudo -v
	@MAKE_PID=$$PPID; (while true; do sudo -n true; sleep 60; kill -0 $$MAKE_PID 2>/dev/null || exit; done) >/dev/null 2>&1 &

zsh-plugins: git
	mkdir -p $(HOME)/.config/zsh/plugins
	[[ -d $(HOME)/.config/zsh/plugins/fzf-tab ]] || git clone https://github.com/Aloxaf/fzf-tab $(HOME)/.config/zsh/plugins/fzf-tab

packages: brew-packages cask-apps editor-extensions

link: stow-mac
	for FILE in $$(\ls -A $(DOTFILES_DIR)/config); do \
		stow --dir=$(DOTFILES_DIR)/config --target=$(HOME) --verbose=1 --ignore='\.DS_Store' $$FILE; \
	done

bin-permissions:
	chmod +x $(DOTFILES_DIR)/bin/*

setup-passwordless-sudo: brew-packages
	@echo "Setting up passwordless sudo for update commands..."
	@USERNAME=$$(whoami); \
	echo "$${USERNAME} ALL=(root) NOPASSWD: /Library/TeX/texbin/tlmgr" | sudo tee /private/etc/sudoers.d/dotfiles-updates > /dev/null; \
	echo "$${USERNAME} ALL=(root) NOPASSWD: /usr/sbin/softwareupdate" | sudo tee -a /private/etc/sudoers.d/dotfiles-updates > /dev/null; \
	sudo chmod 0440 /private/etc/sudoers.d/dotfiles-updates; \
	echo "✓ Passwordless sudo configured"

macos-defaults: bin-permissions packages
	@if [ "$$(uname)" = "Darwin" ]; then \
		dotfiles macos && dotfiles dock; \
	fi

unlink: stow-mac
	for FILE in $$(\ls -A $(DOTFILES_DIR)/config); do \
		stow --delete --dir=$(DOTFILES_DIR)/config --target=$(HOME) --verbose=1 $$FILE; \
	done

brew:
	is-executable brew || NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git: brew
	brew install git

node: brew
	@[[ -s "$(HOME)/.nvm/nvm.sh" ]] || curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | PROFILE=/dev/null bash
	@export NVM_DIR="$(HOME)/.nvm"; \
		. "$(HOME)/.nvm/nvm.sh"; \
		nvm install --lts

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

extra-brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Extrabrewfile || true

extra-cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Extracaskfile || true

extras: extra-brew-packages extra-cask-apps

editor-extensions: cask-apps bin-permissions
	$(DOTFILES_DIR)/bin/install-extensions || true
