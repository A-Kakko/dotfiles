#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_zellij() {
    log_info "=== Zellij セットアップ ==="

    # Zellijがインストールされているか確認
    if ! command_exists zellij; then
        log_warning "Zellij がインストールされていません"
        read -p "Zellij をインストールしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # パッケージマネージャーでインストールを試みる
            local pm=$(detect_package_manager)
            case "$pm" in
                pacman)
                    install_package zellij
                    ;;
                brew)
                    install_package zellij
                    ;;
                *)
                    # Cargoでインストール
                    if command_exists cargo; then
                        log_info "Cargo を使用して Zellij をインストールしています..."
                        cargo install --locked zellij
                    else
                        log_error "Zellij のインストールに失敗しました。手動でインストールしてください:"
                        log_info "  https://zellij.dev/documentation/installation.html"
                        return 1
                    fi
                    ;;
            esac
        else
            log_warning "Zellij のセットアップをスキップしました"
            return 1
        fi
    fi

    # Zellijの設定ファイルをシンボリックリンク
    local zellij_config_source="$DOTFILES_DIR/.config/zellij"
    local zellij_config_target="$HOME/.config/zellij"

    if [ -d "$zellij_config_source" ]; then
        create_symlink "$zellij_config_source" "$zellij_config_target"
    elif [ -f "$DOTFILES_DIR/.config/zellij/config.kdl" ]; then
        # config.kdlファイルのみの場合
        mkdir -p "$HOME/.config/zellij"
        create_symlink "$DOTFILES_DIR/.config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
    else
        log_error "Zellij設定ファイルが見つかりません: $zellij_config_source"
        return 1
    fi

    log_success "Zellij のセットアップが完了しました"
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_zellij
fi
