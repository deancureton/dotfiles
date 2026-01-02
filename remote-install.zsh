#!/bin/zsh

# =============================================================================
# Remote Dotfiles Installation Script
# =============================================================================

SOURCE="https://github.com/deancureton/dotfiles"
TARBALL="$SOURCE/tarball/main"
TARGET="$HOME/.dotfiles"
TAR_CMD="tar -xzv -C $TARGET --strip-components=1 --exclude='{.gitignore}'"

# =============================================================================
# Helper Functions
# =============================================================================

is_executable() {
  type "$1" >/dev/null 2>&1
}

# =============================================================================
# Installation Logic
# =============================================================================

if is_executable "git"; then
  CMD="git clone $SOURCE $TARGET"
elif is_executable "curl"; then
  CMD="curl -#L $TARBALL | $TAR_CMD"
elif is_executable "wget"; then
  CMD="wget --no-check-certificate -O - $TARBALL | $TAR_CMD"
fi

if [ -z "$CMD" ]; then
  echo "No git, curl or wget available. Aborting." >&2
  exit 1
fi

echo "Installing dotfiles..."
mkdir -p "$TARGET"
eval "$CMD"
