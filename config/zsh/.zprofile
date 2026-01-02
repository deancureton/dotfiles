# =============================================================================
# Dotfiles System Configuration
# =============================================================================

DOTFILES_DIR="$HOME/.dotfiles"
PATH="$DOTFILES_DIR/bin:$PATH"
export DOTFILES_DIR

# =============================================================================
# Source System Files
# =============================================================================

# Load general configuration files (aliases loaded later in .zshrc after Oh My Zsh)
# Use setopt to prevent errors if glob patterns don't match
setopt NULL_GLOB
for DOTFILE in "$DOTFILES_DIR"/system/.{function,path,env}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done
unsetopt NULL_GLOB

# Load macOS-specific files
setopt NULL_GLOB
for DOTFILE in "$DOTFILES_DIR"/system/.{env,function}.macos; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done
unsetopt NULL_GLOB

# =============================================================================
# Local Machine-Specific Configuration
# =============================================================================

# Source local zprofile if it exists (for machine-specific settings)
[ -f "$HOME/.zprofile.local" ] && . "$HOME/.zprofile.local"
