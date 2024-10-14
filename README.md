# dotfilesのディレクトリ構造
ホームでヒレクトリ直下にクローンすることをおすすめします。（それ以外にクローンする時は、dotfiles/zshenvの以下を編集してください。）
```zsh
# dotfiles path
export DOTFILES_DIR=~/dotfiles
```

```zsh
~/dotfiles/
├── setup-scripts/
│   ├── install-brew-package   # homebrewのインストールなど
│   ├── install-oh-my-zsh      # oh-my-zshのインストール
│   ├── setup-MacOS            # mac設定のセットアップ
│   └── setup-dotfiles         # dotfilesのセットアップ
├── zsh/
│   ├── alias.zsh              # エイリアスの定義
│   ├── bindkey.zsh            # キーバインドの定義
│   ├── completion.zsh         # キーバインドの定義
│   ├── env.zsh                # 環境変数の設定
│   ├── functions.zsh          # 関数の定義
│   └── oh-my-zsh.zsh          # oh-my-zshの設定
├── .gitconfig                 # Gitの設定ファイル
├── .gitconfig-personal        # 個人のGitの設定ファイル
├── .gitconfig-work            # 会社のGitの設定ファイル
├── .gitconfig                 # Gitの設定ファイル
├── .zshenv                    # 全シェルで適用される設定
└── .zshrc                     # インタラクティブシェル用の設定
```

# Macのセットアップ
```zsh
# 実行権限付与
chmod +x ~/dotfiles/setup/setup-MacOS.sh
# 実行
~/dotfiles/setup/setup-MacOS.sh
```

# zsh環境のセットアップ
## 必要なhomebrewパッケージをインストール
 ```zsh
# 実行権限付与
chmod +x ~/dotfiles/setup/install-brew-packages.sh
# 実行
~/dotfiles/setup/install-brew-packages.sh
```
## oh-my-zshをインストール
 ```zsh
# 実行権限付与
chmod +x ~/dotfiles/setup/install-oh-my-zsh.sh
# 実行
~/dotfiles/setup/install-oh-my-zsh.sh
```
## power10kインストール
 ```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
 ```

## zshファイルのシンボリックリンク適用
```zsh
# 実行権限付与
chmod +x ~/dotfiles/setup/setup-zsh.sh
# 実行
~/dotfiles/setup/setup-zsh.sh
```
