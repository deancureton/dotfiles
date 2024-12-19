my dotfiles repository

features:
- makefile to automatically set up system
- installation of homebrew formulae, casks, and vscode extensions through [homebrew-bundle](https://github.com/Homebrew/homebrew-bundle)
- some automatic macos system settings configuration and dock setup
- custom dotfiles command for maintenance
- automatic symlinking of configuration files using [stow](https://www.gnu.org/software/stow/)
- configurations for:
    - git
    - karabiner, to remap caps lock
    - neovim
        - [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), which comes with [lazy.nvim](https://github.com/folke/lazy.nvim)
        - [harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
        - [lean.nvim](https://github.com/Julian/lean.nvim)
        - [markview.nvim](https://github.com/OXY2DEV/markview.nvim)
        - [mini.nvim](https://github.com/echasnovski/mini.nvim)
        - [snacks.nvim](https://github.com/folke/snacks.nvim)
        - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
        - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
        - theme: [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
    - [sketchybar](https://github.com/FelixKratz/SketchyBar), based on feliz kratz's dotfiles configuration
    - [skhd](https://github.com/koekeishiya/skhd)
    - [starship](https://starship.rs)
    - [topgrade](https://github.com/topgrade-rs/topgrade), used in the dotfiles command
    - vscode, including extensive latex support with [latex-workshop](https://github.com/James-Yu/LaTeX-Workshop)/[hypersnips](https://github.com/draivin/hsnips), and lots of other extensions
        - theme: [vitesse dark soft](https://github.com/antfu/vscode-theme-vitesse)
    - [wezterm](https://wezfurlong.org/wezterm/)
        - theme: [gruvbox dark](https://github.com/mbadolato/iTerm2-Color-Schemes)
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
- https://www.reddit.com/r/wezterm/comments/15hfo32/wezterm_natural_text_editing/
