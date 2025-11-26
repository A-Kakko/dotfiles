#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_starship() {
    log_info "=== Starship セットアップ ==="

    # Starshipがインストールされているか確認
    if ! command_exists starship; then
        log_warning "Starship がインストールされていません"
        read -p "Starship をインストールしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # 公式インストールスクリプトを使用
            log_info "Starship をインストールしています..."
            curl -sS https://starship.rs/install.sh | sh
            if [ $? -ne 0 ]; then
                log_error "Starship のインストールに失敗しました"
                return 1
            fi
        else
            log_warning "Starship のセットアップをスキップしました"
            return 1
        fi
    fi

    # Starshipの設定ファイルをシンボリックリンク
    # starship.toml (通常版)
    local starship_config_source="$DOTFILES_DIR/.config/starship.toml"
    local starship_config_target="$HOME/.config/starship.toml"

    if [ -f "$starship_config_source" ]; then
        create_symlink "$starship_config_source" "$starship_config_target"
    else
        log_warning "Starship設定ファイルが見つかりません: $starship_config_source"
    fi

    # starship-fish.toml (Fish shell用)
    local starship_fish_config_source="$DOTFILES_DIR/.config/starship-fish.toml"
    local starship_fish_config_target="$HOME/.config/starship-fish.toml"

    if [ -f "$starship_fish_config_source" ]; then
        create_symlink "$starship_fish_config_source" "$starship_fish_config_target"
        log_info "Fish shell用の設定も配置しました"
    fi

    log_success "Starship のセットアップが完了しました"
    log_info "シェルの設定ファイル (.bashrc, .zshrc, config.fish など) に以下を追加してください:"
    echo ""
    echo "  # Bash/Zsh の場合:"
    echo "  eval \"\$(starship init bash)\""
    echo "  # または"
    echo "  eval \"\$(starship init zsh)\""
    echo ""
    echo "  # Fish の場合:"
    echo "  starship init fish | source"
    echo ""
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_starship
fi
