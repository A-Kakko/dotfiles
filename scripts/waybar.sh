#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_waybar() {
    log_info "=== Waybar セットアップ ==="

    # Waybarがインストールされているか確認
    if ! command_exists waybar; then
        log_warning "Waybar がインストールされていません"
        read -p "Waybar をインストールしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_package waybar
            if [ $? -ne 0 ]; then
                log_error "Waybar のインストールに失敗しました"
                log_info "Waybar は Wayland コンポジタ用のステータスバーです"
                log_info "手動でインストールしてください: https://github.com/Alexays/Waybar"
                return 1
            fi
        else
            log_warning "Waybar のセットアップをスキップしました"
            return 1
        fi
    fi

    # Waybarの設定ディレクトリをシンボリックリンク
    local waybar_config_source="$DOTFILES_DIR/.config/waybar"
    local waybar_config_target="$HOME/.config/waybar"

    if [ -d "$waybar_config_source" ]; then
        create_symlink "$waybar_config_source" "$waybar_config_target"
    else
        log_error "Waybar設定ディレクトリが見つかりません: $waybar_config_source"
        return 1
    fi

    log_success "Waybar のセットアップが完了しました"
    log_info "Waybar は Hyprland などの Wayland コンポジタで使用されます"
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_waybar
fi
