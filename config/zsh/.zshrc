# =============================================================================
# Performance: Cache expensive operations
# =============================================================================

# Cache brew --prefix to avoid multiple slow calls
if command -v brew >/dev/null 2>&1; then
  if [ -d /opt/homebrew ]; then
    BREW_PREFIX="/opt/homebrew"
  else
    BREW_PREFIX="$(brew --prefix 2>/dev/null)"
  fi
else
  BREW_PREFIX=""
fi

# =============================================================================
# Environment Variables
# =============================================================================

# Library paths
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/flac/lib:/opt/homebrew/opt/libsndfile/lib:$DYLD_LIBRARY_PATH

# PATH additions
export PATH=$PATH:$HOME/.local/share/bob/nvim-bin

# Editor Configuration
export EDITOR="${EDITOR:-cursor}"
export VISUAL="${VISUAL:-$EDITOR}"

# Source local env file if it exists
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# =============================================================================
# Oh My Zsh Configuration
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
ENABLE_CORRECTION="true"

plugins=(git fzf-tab)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Load Aliases (after Oh My Zsh to override its defaults)
# =============================================================================

# Load aliases after Oh My Zsh so they take precedence
[ -f "$DOTFILES_DIR/system/.alias" ] && . "$DOTFILES_DIR/system/.alias"

# =============================================================================
# Zsh Options
# =============================================================================

setopt autocd              # Change directory without typing cd
setopt extendedglob        # Extended globbing patterns
setopt nomatch             # Error if globbing fails
setopt notify              # Report job status immediately
setopt correct             # Command correction
setopt interactive_comments # Allow comments in interactive shell

# =============================================================================
# History Configuration
# =============================================================================

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify

# =============================================================================
# Completion Configuration
# =============================================================================

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true

# =============================================================================
# fzf-tab Configuration
# =============================================================================

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always $realpath'

# =============================================================================
# Zsh Plugins
# =============================================================================

# zsh-autosuggestions (load before syntax-highlighting)
if [ -n "$BREW_PREFIX" ] && [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh-syntax-highlighting (must be loaded last of all zsh plugins)
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -n "$BREW_PREFIX" ] && [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# =============================================================================
# External Tools Initialization
# =============================================================================

# Starship prompt (load early for prompt)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# fzf key bindings and fuzzy completion
# Note: fzf --zsh can be slow, but bindings are needed for Ctrl+R
if command -v fzf >/dev/null 2>&1; then
  # Use faster method if available, otherwise fall back
  if [ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh" 2>/dev/null || true
  else
    source <(fzf --zsh 2>/dev/null) || true
  fi
fi

# zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Conda Initialization (Lazy Loaded)
# Lazy load conda - only initialize when conda command is actually used
conda() {
  if [ -z "$_CONDA_INITIALIZED" ]; then
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
      eval "$__conda_setup"
    else
      if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
      else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
      fi
    fi
    unset __conda_setup
    export _CONDA_INITIALIZED=1
  fi
  command conda "$@"
}

# =============================================================================
# Functions
# =============================================================================

# yazi cwd on exit
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}