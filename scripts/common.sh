#!/bin/bash

# 色付き出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# DOTFILESディレクトリのパスを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ログ関数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# シンボリックリンクを作成する関数
create_symlink() {
    local source="$1"
    local target="$2"

    # targetの親ディレクトリを作成
    mkdir -p "$(dirname "$target")"

    # targetが既にシンボリックリンクで、正しいsourceを指している場合
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        log_info "既に正しくリンクされています: $target -> $source"
        return 0
    fi

    # targetが既に存在する場合
    if [ -e "$target" ] || [ -L "$target" ]; then
        log_warning "既に存在します: $target"
        read -p "バックアップして上書きしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$target" "$backup"
            log_info "バックアップを作成しました: $backup"
        else
            log_warning "スキップしました: $target"
            return 1
        fi
    fi

    # シンボリックリンクを作成
    ln -s "$source" "$target"
    log_success "リンクを作成しました: $target -> $source"
    return 0
}

# コマンドが存在するか確認する関数
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# パッケージマネージャーを検出する関数
detect_package_manager() {
    if command_exists apt-get; then
        echo "apt"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists yum; then
        echo "yum"
    elif command_exists pacman; then
        echo "pacman"
    elif command_exists brew; then
        echo "brew"
    else
        echo "unknown"
    fi
}

# パッケージをインストールする関数
install_package() {
    local package="$1"
    local pm=$(detect_package_manager)

    if command_exists "$package"; then
        log_info "$package は既にインストールされています"
        return 0
    fi

    log_info "$package をインストールしています..."

    case "$pm" in
        apt)
            sudo apt-get update && sudo apt-get install -y "$package"
            ;;
        dnf)
            sudo dnf install -y "$package"
            ;;
        yum)
            sudo yum install -y "$package"
            ;;
        pacman)
            sudo pacman -S --noconfirm "$package"
            ;;
        brew)
            brew install "$package"
            ;;
        *)
            log_error "パッケージマネージャーが見つかりません。手動で $package をインストールしてください。"
            return 1
            ;;
    esac

    if [ $? -eq 0 ]; then
        log_success "$package のインストールが完了しました"
        return 0
    else
        log_error "$package のインストールに失敗しました"
        return 1
    fi
}
