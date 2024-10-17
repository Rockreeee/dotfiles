#!/bin/zsh

# Homebrewのインストール
if ! command -v brew &> /dev/null; then
    echo "💪 Homebrewをインストールしています..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "👋 Homebrewはすでにインストールされています。"
fi

# Homebrewのアップデート
echo "💪 Homebrewをアップデートしています..."
brew update

# アプリケーションのインストール
echo "💪 アプリケーションをインストールしています..."
brew install --cask google-chrome
brew install --cask microsoft-office
brew install --cask visual-studio-code
brew install --cask deepl
brew install --cask iterm2
brew install --cask slack
brew install --cask zoom
brew install --cask chatgpt
brew install --cask raycast
brew install --cask rectangle
brew install --cask google-japanese-ime
brew install --cask astah-proffesional

# 完了メッセージ
echo "🤛 アプリのインストールが完了しました！"