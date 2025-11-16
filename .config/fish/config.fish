# ==================== PATH設定 ==================== #
# Omarchy binディレクトリをPATHに追加
set -gx OMARCHY_PATH $HOME/.local/share/omarchy
set -gx PATH $OMARCHY_PATH/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

#==================== エイリアス/Abbreviation ==================== #

# Git関連（コマンドで追加推奨）
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gp 'git push'
abbr -a gl 'git log --oneline'

# 一般的なコマンド
abbr -a ll 'ls -lah'
abbr -a v nvim
abbr -a c clear
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'

abbr -a vim nvim
# ==================== Zellij関連のエイリアス ==================== #
alias ta='zellij attach'
alias tl='zellij list-sessions'
alias tk='zellij kill-session'
alias tn='zellij -s'
alias z='zellij'
alias zls='zellij list-sessions'
alias za='zellij attach'
alias zk='zellij kill-session'
alias zedit='$EDITOR ~/.config/zellij/config.kdl'

# ==================== 環境変数 ==================== #
# 日本語環境
set -x LANG ja_JP.UTF-8
set -x LC_ALL ja_JP.UTF-8

# エディタ
set -x EDITOR nvim
set -x VISUAL nvim

# ==================== Fisher プラグイン（インストール済みなら） ==================== #
# z - ディレクトリジャンプ
# fzf - 曖昧検索
# ghq - リポジトリ管理
