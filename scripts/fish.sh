#!/bin/bash

# 共通関数を読み込み
source "$(dirname "$0")/common.sh"

setup_fish() {
    log_info "=== Fish Shell セットアップ ==="

    # Fishがインストールされているか確認
    if ! command_exists fish; then
        log_warning "Fish Shell がインストールされていません"
        read -p "Fish Shell をインストールしますか? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_package fish
            if [ $? -ne 0 ]; then
                log_error "Fish Shell のインストールに失敗しました"
                return 1
            fi
        else
            log_warning "Fish Shell のセットアップをスキップしました"
            return 1
        fi
    fi

    # Fishの設定ディレクトリをシンボリックリンク
    local fish_config_source="$DOTFILES_DIR/.config/fish"
    local fish_config_target="$HOME/.config/fish"

    if [ -d "$fish_config_source" ]; then
        create_symlink "$fish_config_source" "$fish_config_target"
    else
        log_error "Fish設定ディレクトリが見つかりません: $fish_config_source"
        return 1
    fi

    # Fisherのインストール確認
    log_info "Fisher プラグインマネージャーをセットアップしています..."

    # Fisherがインストールされているか確認（fish内で実行）
    if fish -c "type -q fisher" 2>/dev/null; then
        log_info "Fisher は既にインストールされています"
    else
        log_info "Fisher をインストールしています..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

        if [ $? -eq 0 ]; then
            log_success "Fisher のインストールが完了しました"
        else
            log_error "Fisher のインストールに失敗しました"
            log_info "手動でインストールしてください: https://github.com/jorgebucaran/fisher"
            return 1
        fi
    fi

    # fish_pluginsファイルが存在する場合、プラグインをインストール
    local fish_plugins="$fish_config_source/fish_plugins"
    if [ -f "$fish_plugins" ]; then
        log_info "fish_plugins からプラグインをインストールしています..."
        fish -c "fisher update"
        log_success "プラグインのインストールが完了しました"
    else
        log_info "fish_plugins ファイルが見つかりません。プラグインのインストールをスキップします"
        log_info "プラグインをインストールする場合は、fish内で 'fisher install <plugin>' を実行してください"
    fi

    log_success "Fish Shell のセットアップが完了しました"
    log_info "デフォルトシェルを変更する場合は以下を実行してください:"
    echo "  chsh -s \$(which fish)"
}

# スクリプトが直接実行された場合
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    setup_fish
fi
