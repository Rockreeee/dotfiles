#!/bin/zsh

# Homebrewのインストール
if ! command -v brew &> /dev/null; then
    echo "💪 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo echo "👋 Homebrew is already installed."
fi

# Homebrewのアップデート
echo "💪 Updating Homebrew..."
brew update

# パッケージのインストール
echo "💪 Installing packages..."
brew install jq       # JSON処理ツール
brew install fzf       
brew install bat       
brew install node      
brew install rbenv      
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install nkf
brew install tree
brew install git-lfs
git lfs install

# 完了メッセージ
echo "🤛 Application installation complete!"