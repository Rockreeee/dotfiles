# ------------------------------------------------------------------------
# Android Studio ADB
# ------------------------------------------------------------------------
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

# ------------------------------------------------------------------------
# rbenv
# ------------------------------------------------------------------------
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# ------------------------------------------------------------------------
# nodenv
# ------------------------------------------------------------------------
export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

