my dotfiles repository

> note: designed for macos - some stuff might work elsewhere but ymmv

features:
- makefile to automatically set up system
- installation of homebrew formulae, casks, and vscode extensions through [homebrew-bundle](https://github.com/Homebrew/homebrew-bundle)
- some automatic macos system settings configuration and dock setup
- custom dotfiles command for maintenance
- automatic symlinking of configuration files using [stow](https://www.gnu.org/software/stow/)
- configurations for:
    - git
    - [ghostty](https://ghostty.org/), modern terminal emulator with Zenwritten Dark theme
    - karabiner, to remap caps lock
    - neovim with native vim.pack plugin management
        - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
        - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
        - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with LSP, path, and snippet completion
        - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
        - [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
        - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
        - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
        - [typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim)
        - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
        - theme: [onedark.nvim](https://github.com/navarasu/onedark.nvim)
    - [sketchybar](https://github.com/FelixKratz/SketchyBar), based on feliz kratz's dotfiles configuration
    - [skhd](https://github.com/koekeishiya/skhd)
    - [starship](https://starship.rs)
    - [topgrade](https://github.com/topgrade-rs/topgrade), used in the dotfiles command
    - vscode, including extensive latex support with [latex-workshop](https://github.com/James-Yu/LaTeX-Workshop)/[hypersnips](https://github.com/draivin/hsnips), and lots of other extensions
        - theme: [vitesse dark soft](https://github.com/antfu/vscode-theme-vitesse)
    - [yabai](https://github.com/koekeishiya/yabai), which integrates with sketchybar
    - zsh
        - [oh-my-zsh](https://ohmyz.sh/)
        - [fzf-tab](https://github.com/Aloxaf/fzf-tab)
        - [zsh-completions](https://github.com/zsh-users/zsh-completions?tab=readme-ov-file)
        - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
        - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
        - [lsd](https://github.com/lsd-rs/lsd)
        - [zoxide](https://github.com/ajeetdsouza/zoxide)

to install, run
```zsh
xcode-select --install
bash -c "`curl -fsSL https://raw.githubusercontent.com/deancureton/dotfiles/master/remote-install.zsh`"
cd ~/.dotfiles
make
```
after running, you have access to the `dotfiles` command:
```
$ dotfiles
Usage: dotfiles <command>

Commands:
   help               This help message
   edit               Open dotfiles in editor (nvim)
   clean              Clean up caches (brew, pip)
   update             Update packages and pkg managers (OS, brew, npm, gem, pip)
   macos              Apply macOS system defaults
   dock               Apply OS X Dock settings
   start              Start services
```

things i used/was inspired by:
- https://github.com/webpro/dotfiles
- https://github.com/FelixKratz/dotfiles
- https://github.com/Einlar/latex_snippets
- https://github.com/antfu/vscode-settings
- https://github.com/alextricity25/nvim_weekly_plugin_configs
- https://www.youtube.com/watch?v=ud7YxC33Z3w
- https://www.youtube.com/watch?v=9_I0bySQoCs
