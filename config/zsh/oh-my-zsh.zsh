typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Powerlevel10k instant prompt (高速化)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh の設定
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# プラグイン設定
plugins=(
  git
  web-search
)
source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions
if [ -f "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh-syntax-highlighting
if [ -f "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Powerlevel10k の設定ファイル
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# シェルの終了時のクリーンアップ
autoload -Uz compinit && compinit