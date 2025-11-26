#!/bin/bash

# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 共通関数を読み込み
source "$SCRIPT_DIR/scripts/common.sh"

# ヘルプメッセージを表示
show_help() {
    cat << EOF
使い方: ./setup.sh [OPTIONS]

OPTIONS:
    -h, --help          このヘルプメッセージを表示
    -a, --all           全てのツールをセットアップ
    -n, --nvim          Neovimのみセットアップ
    -s, --starship      Starshipのみセットアップ
    -g, --ghostty       Ghosttyのみセットアップ
    -z, --zellij        Zellijのみセットアップ
    -y, --yazi          Yaziのみセットアップ
    -w, --waybar        Waybarのみセットアップ
    -f, --fish          Fish Shellのみセットアップ

例:
    ./setup.sh --all              # 全てをセットアップ
    ./setup.sh --nvim --starship  # NvimとStarshipのみセットアップ
    ./setup.sh --fish --yazi      # FishとYaziのみセットアップ
    ./setup.sh                    # 対話モードで選択

EOF
}

# 対話的にツールを選択
interactive_setup() {
    log_info "=== Dotfiles セットアップ ==="
    log_info "セットアップするツールを選択してください"
    echo ""

    read -p "Neovim をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_NVIM=true
    fi

    read -p "Starship をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_STARSHIP=true
    fi

    read -p "Ghostty をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_GHOSTTY=true
    fi

    read -p "Zellij をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_ZELLIJ=true
    fi

    read -p "Yazi をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_YAZI=true
    fi

    read -p "Waybar をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_WAYBAR=true
    fi

    read -p "Fish Shell をセットアップしますか? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        SETUP_FISH=true
    fi

    echo ""
}

# セットアップを実行
run_setup() {
    local success_count=0
    local fail_count=0

    if [ "$SETUP_NVIM" = true ]; then
        log_info "Neovim のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/nvim.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    if [ "$SETUP_STARSHIP" = true ]; then
        log_info "Starship のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/starship.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    if [ "$SETUP_GHOSTTY" = true ]; then
        log_info "Ghostty のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/ghostty.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    if [ "$SETUP_ZELLIJ" = true ]; then
        log_info "Zellij のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/zellij.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    if [ "$SETUP_YAZI" = true ]; then
        log_info "Yazi のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/yazi.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    if [ "$SETUP_WAYBAR" = true ]; then
        log_info "Waybar のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/waybar.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    if [ "$SETUP_FISH" = true ]; then
        log_info "Fish Shell のセットアップを開始..."
        if bash "$SCRIPT_DIR/scripts/fish.sh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    fi

    # 結果を表示
    log_info "=== セットアップ完了 ==="
    log_success "成功: $success_count"
    if [ $fail_count -gt 0 ]; then
        log_error "失敗: $fail_count"
    fi
}

# メイン処理
main() {
    # オプションがない場合は対話モード
    if [ $# -eq 0 ]; then
        interactive_setup
        run_setup
        exit 0
    fi

    # オプション解析
    SETUP_NVIM=false
    SETUP_STARSHIP=false
    SETUP_GHOSTTY=false
    SETUP_ZELLIJ=false
    SETUP_YAZI=false
    SETUP_WAYBAR=false
    SETUP_FISH=false

    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -a|--all)
                SETUP_NVIM=true
                SETUP_STARSHIP=true
                SETUP_GHOSTTY=true
                SETUP_ZELLIJ=true
                SETUP_YAZI=true
                SETUP_WAYBAR=true
                SETUP_FISH=true
                shift
                ;;
            -n|--nvim)
                SETUP_NVIM=true
                shift
                ;;
            -s|--starship)
                SETUP_STARSHIP=true
                shift
                ;;
            -g|--ghostty)
                SETUP_GHOSTTY=true
                shift
                ;;
            -z|--zellij)
                SETUP_ZELLIJ=true
                shift
                ;;
            -y|--yazi)
                SETUP_YAZI=true
                shift
                ;;
            -w|--waybar)
                SETUP_WAYBAR=true
                shift
                ;;
            -f|--fish)
                SETUP_FISH=true
                shift
                ;;
            *)
                log_error "不明なオプション: $1"
                show_help
                exit 1
                ;;
        esac
    done

    run_setup
}

# スクリプトを実行
main "$@"
