# dotfiles path
export DOTFILES_DIR=~/dotfiles

# history
export HISTSIZE=10000
export SAVEHIST=10000

# Homebrew のパス設定
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
elif [ -d "/usr/local/bin" ]; then
    export PATH="/usr/local/bin:$PATH"
fi