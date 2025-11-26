#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_ghostty() {
    log_info "=== Ghostty セットアップ ==="

    # Ghosttyがインストールされているか確認
    if ! command_exists ghostty; then
        log_warning "Ghostty がインストールされていません"
        log_info "Ghostty は以下からインストールできます:"
        log_info "  https://ghostty.org/"
        read -p "Ghostty をインストール済みとしてスキップしますか? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_warning "Ghostty のセットアップをスキップしました"
            return 1
        fi
    fi

    # Ghosttyの設定ファイルをシンボリックリンク
    local ghostty_config_source="$DOTFILES_DIR/.config/ghostty"
    local ghostty_config_target="$HOME/.config/ghostty"

    if [ -d "$ghostty_config_source" ]; then
        create_symlink "$ghostty_config_source" "$ghostty_config_target"
    elif [ -f "$ghostty_config_source/config" ]; then
        # ディレクトリではなく単一ファイルの場合
        mkdir -p "$HOME/.config/ghostty"
        create_symlink "$ghostty_config_source/config" "$ghostty_config_target/config"
    else
        log_error "Ghostty設定ファイルが見つかりません: $ghostty_config_source"
        return 1
    fi

    log_success "Ghostty のセットアップが完了しました"
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_ghostty
fi
