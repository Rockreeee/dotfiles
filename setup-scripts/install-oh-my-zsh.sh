#!/bin/zsh

# Oh My Zshがすでにインストールされているか確認
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "👋 Oh My Zshは既にインストールされています。スキップします。"
else
  echo "💪 Oh My Zshをインストールしています..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Powerlevel10kがすでにインストールされているか確認
POWERLEVEL10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$POWERLEVEL10K_DIR" ]; then
  echo "👋 Powerlevel10kは既にインストールされています。スキップします。"
else
  echo "💪 Powerlevel10kをインストールしています..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$POWERLEVEL10K_DIR"
fi

# 完了メッセージ
echo "🤛 oh-my-zsh setup complete!"