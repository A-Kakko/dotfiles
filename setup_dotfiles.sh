#!/bin/bash

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

# dotfilesディレクトリが存在しない場合は作成
mkdir -p "$DOTFILES_DIR"

# 色付き出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ファイルまたはディレクトリを移動してシンボリックリンクを作成する関数
link_dotfile() {
    local source="$1"
    local target="$DOTFILES_DIR/$2"
    
    # sourceが存在しない場合はスキップ
    if [ ! -e "$source" ] && [ ! -L "$source" ]; then
        echo -e "${YELLOW}スキップ: $source は存在しません${NC}"
        return
    fi
    
    # 既にシンボリックリンクの場合はスキップ
    if [ -L "$source" ]; then
        echo -e "${YELLOW}スキップ: $source は既にシンボリックリンクです${NC}"
        return
    fi
    
    # targetの親ディレクトリを作成
    mkdir -p "$(dirname "$target")"
    
    # targetが既に存在する場合の処理
    if [ -e "$target" ]; then
        echo -e "${YELLOW}警告: $target は既に存在します。スキップします。${NC}"
        return
    fi
    
    # ファイルを移動
    echo -e "${GREEN}移動: $source -> $target${NC}"
    mv "$source" "$target"
    
    # シンボリックリンクを作成
    echo -e "${GREEN}リンク作成: $source -> $target${NC}"
    ln -s "$target" "$source"
}

# メイン処理
echo "=== Dotfiles Setup Script ==="
echo "Dotfilesディレクトリ: $DOTFILES_DIR"
echo ""

# 管理したいdotfilesをここに追加
# 使い方: link_dotfile "元のパス" "dotfiles内の相対パス"

# シェル設定
link_dotfile "$HOME/.bashrc" ".bashrc"
link_dotfile "$HOME/.bash_profile" ".bash_profile"
link_dotfile "$HOME/.zshrc" ".zshrc"
link_dotfile "$HOME/.tmux.conf" ".tmux.conf"

# Hyprland関連
link_dotfile "$HOME/.config/hypr" ".config/hypr"
link_dotfile "$HOME/.config/waybar" ".config/waybar"
link_dotfile "$HOME/.config/eww" ".config/eww"
link_dotfile "$HOME/.config/"

#エディタ
link_dotfile "$HOME/.config/Code/User/settings.json" ".config/Code/User/settings.json"
link_dotfile "$HOME/.config/Code/User/keybindings.json" ".config/Code/User/keybindings.json"
link_dotfile "$HOME/.config/zed/settings.json" ".config/zed/settings.json"
link_dotfile "$HOME/.config/zed/keymap.json" ".config/zed/keymap.json"

# その他の設定
link_dotfile "$HOME/.config/fish" ".config/fish"
link_dotfile "$HOME/.vimrc" ".vimrc"
link_dotfile "$HOME/.gitconfig" ".gitconfig"

link_dotfile "$HOME/.config/kitty" ".config/kitty"
link_dotfile "$HOME/.config/alacritty" ".config/alacritty"
link_dotfile "$HOME/.config/yazi" ".config/yazi"
link_dotfile "$HOME/.config/zed" ".config/zed"
link_dotfile "$HOME/.config/fcitx5" ".config/fcitx5"
link_dotfile "$HOME/Documents/mytools/setup_dotfiles.sh" "setup_dotfiles.sh"
# システムモニタリング
link_dotfile "$HOME/.config/btop" ".config/btop"

# 追加したい設定ファイルがあればここに追記
# link_dotfile "$HOME/.config/nvim" ".config/nvim"
# link_dotfile "$HOME/.tmux.conf" ".tmux.conf"

echo ""
echo -e "${GREEN}=== 完了 ===${NC}"
echo "次のステップ:"
echo "1. cd $DOTFILES_DIR"
echo "2. git init"
echo "3. git add ."
echo "4. git commit -m 'Initial commit'"
