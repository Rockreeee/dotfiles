# ------------------------------------------------------------------------
# completion
# ------------------------------------------------------------------------

source $ZSHRC_DIR/completion.zsh

# ------------------------------------------------------------------------
# alias
# ------------------------------------------------------------------------

source $ZSHRC_DIR/alias.zsh

# ------------------------------------------------------------------------
# bindkey
# ------------------------------------------------------------------------

source $ZSHRC_DIR/bindkey.zsh

# ------------------------------------------------------------------------
# wordstyle
# ------------------------------------------------------------------------

source $ZSHRC_DIR/wordstyle.zsh

# ------------------------------------------------------------------------
# history
# ------------------------------------------------------------------------

source $ZSHRC_DIR/history.zsh

# ------------------------------------------------------------------------
# Other
# ファイル単位で切り出すと、1行のみになってしまう場合のみここに記載
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
# local config
# ------------------------------------------------------------------------

if [ -e $ZDOTDIR/.zlocal ]; then
    source $ZDOTDIR/.zlocal
fi

# ------------------------------------------------------------------------
# prompt
# ------------------------------------------------------------------------

source $ZSHRC_DIR/prompt.zsh