

export TERM=xterm-256color
#===========================tmux関係======================================
# tmux自動起動（tmux内では実行しない）
if status is-interactive
    and test $SHLVL -eq 1
    and not set -q TMUX
    # セッションが存在するか確認
    if tmux has-session -t main 2>/dev/null
        # 既存セッションには普通に接続
        exec tmux attach-session -t main
    else
        # 新規作成時のみ分割
        exec tmux new-session -s main \; split-window -h \; split-window -v
    end
end

#===========================yazi関係=========================================
# ~/.config/fish/config.fish に追加
function ya
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
#============================micro関係=======================================
# nanoの代わりにmicroを使う
alias nano='micro'

# sudoeditもmicroに
set -x SUDO_EDITOR micro
set -x EDITOR micro
set -x VISUAL micro
