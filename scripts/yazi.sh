#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_yazi() {
    log_info "=== Yazi セットアップ ==="

    # Yaziがインストールされているか確認
    if ! command_exists yazi; then
        log_warning "Yazi がインストールされていません"
        read -p "Yazi をインストールしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # パッケージマネージャーでインストールを試みる
            local pm=$(detect_package_manager)
            case "$pm" in
                pacman)
                    install_package yazi
                    ;;
                brew)
                    install_package yazi
                    ;;
                *)
                    # Cargoでインストール
                    if command_exists cargo; then
                        log_info "Cargo を使用して Yazi をインストールしています..."
                        cargo install --locked yazi-fm yazi-cli
                    else
                        log_error "Yazi のインストールに失敗しました。手動でインストールしてください:"
                        log_info "  https://yazi-rs.github.io/docs/installation"
                        return 1
                    fi
                    ;;
            esac
        else
            log_warning "Yazi のセットアップをスキップしました"
            return 1
        fi
    fi

    # Yaziの設定ディレクトリをシンボリックリンク
    local yazi_config_source="$DOTFILES_DIR/.config/yazi"
    local yazi_config_target="$HOME/.config/yazi"

    if [ -d "$yazi_config_source" ]; then
        create_symlink "$yazi_config_source" "$yazi_config_target"
    else
        log_error "Yazi設定ディレクトリが見つかりません: $yazi_config_source"
        return 1
    fi

    log_success "Yazi のセットアップが完了しました"
    log_info "プラグインは初回起動時に自動でインストールされます"
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_yazi
fi
