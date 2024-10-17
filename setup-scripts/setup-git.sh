#!/bin/zsh

DOTFILES_DIR=~/dotfiles

# バックアップディレクトリ
BACKUP_DIR=~/.backup-git

# バックアップディレクトリが存在しない場合は作成
if [ ! -d "$BACKUP_DIR" ]; then
    echo "💪 Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# シンボリックリンクを作成する関数
create_symlink() {
    source="$DOTFILES_DIR/$1"
    destination="$HOME/$1"

    if [ -e "$destination" ]; then
        if [ ! -L "$destination" ]; then  # シンボリックリンクでない場合のみ移動
            echo "😲 $destination already exists. Moving to backup..."
            mv "$destination" "$BACKUP_DIR"
        else
            echo "👋 $destination is a symlink, not moving."
    fi

    ln -nfs "$source" "$destination"  # シンボリックリンクを作成
    echo "💪 Created symlink: $destination -> $source"
}

# Git 設定
echo "🚀 Setting up Git..."
create_symlink ".gitconfig"

# 完了メッセージ
echo "🤛 Git setup complete!"