DOTFILES_DIR="$HOME/.dotfiles"
PATH="$DOTFILES_DIR/bin:$PATH"
export DOTFILES_DIR

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,alias}; do
  . "$DOTFILE"
done

for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function}.macos; do
  . "$DOTFILE"
done
