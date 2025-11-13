

export TERM=xterm-256color
#===========================tmux関係======================================
# tmux自動起動（tmux内では実行しない）
###if status is-interactive
   # and test $SHLVL -eq 1
   # and not set -q TMUX
    # セッションが存在するか確認
  #  if tmux has-session -t main 2>/dev/null
        # 既存セッションには普通に接続
 #       exec tmux attach-session -t main
#    else
        # 新規作成時のみ分割
#       exec tmux new-session -s main \; split-window -h \; split-window -v
#    end
#end
# Fish shell configuration for Zellij

# ============ Zellij自動起動設定 ============
# tmuxの代わりにzellijを自動起動
if status is-interactive
    # Zellijセッション内でなく、SSHセッションでもない場合に自動起動
    if not set -q ZELLIJ
        # 既存のセッションに接続するか、新規作成
        if zellij list-sessions 2>/dev/null | grep -q .
            # セッションが存在する場合は接続
            zellij attach -c
        else
            # セッションがない場合は新規作成
            zellij
        end
    end
end

# ============ Zellijのエイリアス ============
# tmuxの習慣をzellijに移行しやすくする
alias ta='zellij attach'           # tmux attach相当
alias tl='zellij list-sessions'    # tmux list-sessions相当
alias tk='zellij kill-session'     # tmux kill-session相当
alias tn='zellij -s'               # 新しい名前付きセッション

# Zellijの便利なエイリアス
alias z='zellij'
alias zls='zellij list-sessions'
alias za='zellij attach'
alias zk='zellij kill-session'

# ============ その他の便利な設定 ============
# Zellijの設定ファイルを素早く編集
alias zedit='$EDITOR ~/.config/zellij/config.kdl'

# Zellijの設定をリロード（セッションを再起動）
function zreload
    echo "Zellijセッションを再起動します..."
    zellij kill-session -a
    zellij
end

# ============ 従来のtmuxコマンドをzellijに転送 ============
# tmuxのコマンドを打ち間違えた時のための対応
function tmux
    echo "tmuxは使用していません。代わりにzellijを使用してください。"
    echo "  tmux attach → zellij attach"
    echo "  tmux ls     → zellij list-sessions"
    echo "  tmux kill   → zellij kill-session"
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

#===========================alias===============================================
abbr -a g git
abbr -a dc docker-compose
abbr -a gc git commit
abbr -a gcm git commit -m
abbr -a gpom git push -u origin main
