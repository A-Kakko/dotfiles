#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_nvim() {
    log_info "=== Neovim セットアップ ==="

    # Neovimがインストールされているか確認
    if ! command_exists nvim; then
        log_warning "Neovim がインストールされていません"
        read -p "Neovim をインストールしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_package nvim || install_package neovim
        else
            log_warning "Neovim のセットアップをスキップしました"
            return 1
        fi
    fi

    # Neovimの設定ディレクトリをシンボリックリンク
    local nvim_config_source="$DOTFILES_DIR/.config/nvim"
    local nvim_config_target="$HOME/.config/nvim"

    if [ -d "$nvim_config_source" ]; then
        create_symlink "$nvim_config_source" "$nvim_config_target"
    else
        log_error "Neovim設定ディレクトリが見つかりません: $nvim_config_source"
        return 1
    fi

    # Lazy.nvimが必要な場合は自動インストールされることを通知
    log_info "プラグインマネージャー (Lazy.nvim) は初回起動時に自動でインストールされます"

    log_success "Neovim のセットアップが完了しました"
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_nvim
fi
