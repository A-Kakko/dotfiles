#!/bin/bash

# 色付き出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="git@github.com:あなたのユーザー名/dotfiles.git"  # ここを自分のリポジトリURLに変更

echo -e "${BLUE}=== Dotfiles セットアップスクリプト ===${NC}"
echo ""

# 1. dotfilesリポジトリをクローン
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}$DOTFILES_DIR は既に存在します${NC}"
    read -p "既存のディレクトリを削除して再クローンしますか？ (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$DOTFILES_DIR"
    else
        echo -e "${RED}セットアップを中止します${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}dotfilesをクローンしています...${NC}"
git clone "$REPO_URL" "$DOTFILES_DIR"

if [ $? -ne 0 ]; then
    echo -e "${RED}クローンに失敗しました${NC}"
    exit 1
fi

# 2. シンボリックリンクを作成する関数
create_symlink() {
    local source="$DOTFILES_DIR/$1"
    local target="$HOME/$1"
    
    # sourceが存在しない場合はスキップ
    if [ ! -e "$source" ]; then
        echo -e "${YELLOW}スキップ: $source は存在しません${NC}"
        return
    fi
    
    # targetの親ディレクトリを作成
    mkdir -p "$(dirname "$target")"
    
    # targetが既に存在する場合の処理
    if [ -e "$target" ] || [ -L "$target" ]; then
        # 既にシンボリックリンクで、同じ場所を指している場合はスキップ
        if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
            echo -e "${YELLOW}スキップ: $target は既に正しくリンクされています${NC}"
            return
        fi
        
        # バックアップを作成
        backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}バックアップ: $target -> $backup${NC}"
        mv "$target" "$backup"
    fi
    
    # シンボリックリンクを作成
    echo -e "${GREEN}リンク作成: $target -> $source${NC}"
    ln -s "$source" "$target"
}

# 3. シンボリックリンクを作成
echo ""
echo -e "${BLUE}シンボリックリンクを作成しています...${NC}"

# シェル設定
create_symlink ".bashrc"
create_symlink ".bash_profile"
create_symlink ".zshrc"

# Fish & Tmux
create_symlink ".config/fish"
create_symlink ".tmux.conf"

# Hyprland関連
create_symlink ".config/hypr"
create_symlink ".config/waybar"
create_symlink ".config/eww"

# その他の設定
create_symlink ".vimrc"
create_symlink ".gitconfig"
create_symlink ".config/kitty"
create_symlink ".config/alacritty"
create_symlink ".config/neofetch"

# 追加したい設定ファイルがあればここに追記
# create_symlink ".config/nvim"
# create_symlink ".config/Code"

# 4. oh-my-fishの復元
echo ""
if [ -f "$DOTFILES_DIR/omf_bundle" ]; then
    echo -e "${BLUE}oh-my-fishプラグインを復元しますか？${NC}"
    echo "事前に oh-my-fish をインストールしておく必要があります"
    echo "インストールコマンド: curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish"
    read -p "復元を実行しますか？ (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v omf &> /dev/null; then
            omf import "$DOTFILES_DIR/omf_bundle"
            echo -e "${GREEN}oh-my-fishプラグインを復元しました${NC}"
        else
            echo -e "${RED}omfコマンドが見つかりません。先にoh-my-fishをインストールしてください${NC}"
        fi
    fi
fi

# 5. 完了メッセージ
echo ""
echo -e "${GREEN}=== セットアップ完了 ===${NC}"
echo ""
echo "次のステップ:"
echo "1. シェルを再起動するか、設定を再読み込みしてください"
echo "   - Bash: source ~/.bashrc"
echo "   - Fish: source ~/.config/fish/config.fish"
echo "2. バックアップファイル(*.backup.*)が不要なら削除してください"
echo "3. oh-my-fishをまだインストールしていない場合:"
echo "   curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish"
echo ""
echo -e "${BLUE}Enjoy your dotfiles!${NC}"
