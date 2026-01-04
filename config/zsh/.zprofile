# =============================================================================
# Dotfiles System Configuration
# =============================================================================

DOTFILES_DIR="$HOME/.dotfiles"
PATH="$DOTFILES_DIR/bin:$PATH"
export DOTFILES_DIR

# =============================================================================
# Local Machine-Specific Configuration
# =============================================================================

# Source local zprofile FIRST (sets up Homebrew paths, etc.)
# This must run before .alias so lsd and other Homebrew tools are in PATH
[ -f "$HOME/.zprofile.local" ] && . "$HOME/.zprofile.local"

# =============================================================================
# Source System Files
# =============================================================================

# Load general configuration files (now that paths are set up)
# Use setopt to prevent errors if glob patterns don't match
setopt NULL_GLOB
for DOTFILE in "$DOTFILES_DIR"/system/.{function,env,alias}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done
unsetopt NULL_GLOB

# Load macOS-specific files
setopt NULL_GLOB
for DOTFILE in "$DOTFILES_DIR"/system/.{env,function}.macos; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done
unsetopt NULL_GLOB
