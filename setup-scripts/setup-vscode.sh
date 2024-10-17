#!/bin/sh

DOTFILES_DIR=~/dotfiles

# バックアップディレクトリ
BACKUP_DIR=~/.backup-vscode

# VSCodeディレクトリ
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User


# バックアップディレクトリが存在しない場合は作成
if [ ! -d "$BACKUP_DIR" ]; then
    echo "💪 Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# シンボリックリンクを作成する関数
create_symlink() {
    source="$DOTFILES_DIR/config/vscode/$1"
    destination="$VSCODE_SETTING_DIR/$1"

    if [ -e "$destination" ]; then
        if [ ! -L "$destination" ]; then  # シンボリックリンクでない場合のみ移動
            echo "😲 $destination already exists. Moving to backup..."
            mv "$destination" "$BACKUP_DIR"
        else
            echo "👋 $destination is a symlink, not moving."
        fi
    fi

    ln -nfs "$source" "$destination"  # シンボリックリンクを作成
    echo "💪 Created symlink: $destination -> $source"
}

# vscode 設定
echo "🚀 Setting up Vscode..."
create_symlink "keybindings.json"
create_symlink "settings.json"

# 拡張機能をインストール
# インストール済みの拡張機能を取得
installed_extensions=$(code --list-extensions)

# extensionsファイルから不足している拡張機能をインストール
while IFS= read -r line || [ -n "$line" ]; do
    if ! echo "$installed_extensions" | grep -q "$line"; then
        echo "💪 Installing $line..."
        code --install-extension "$line"
    else
        echo "👋 $line is already installed, skipping."
    fi
done < "$DOTFILES_DIR/config/vscode/extensions"

# 完了メッセージ
echo "🤛 VSCode setup complete!"