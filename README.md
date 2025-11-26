# Dotfiles

個人的な開発環境の設定ファイルを管理するリポジトリです。

## 概要

このリポジトリには以下のツールの設定が含まれています：

- **Neovim** - テキストエディタ
- **Starship** - クロスシェルプロンプト
- **Ghostty** - ターミナルエミュレータ
- **Zellij** - ターミナルマルチプレクサ
- **Yazi** - ターミナルファイルマネージャ
- **Waybar** - Wayland用ステータスバー
- **Fish Shell** - モダンなシェル（Fisherプラグインマネージャ対応）

## ディレクトリ構造

```
dotfiles/
├── .config/
│   ├── nvim/           # Neovim設定
│   ├── ghostty/        # Ghostty設定
│   ├── zellij/         # Zellij設定
│   ├── yazi/           # Yazi設定
│   ├── waybar/         # Waybar設定
│   ├── fish/           # Fish Shell設定
│   ├── starship.toml   # Starship設定
│   └── starship-fish.toml  # Starship (Fish shell用)
├── scripts/
│   ├── common.sh       # 共通関数
│   ├── nvim.sh         # Neovimセットアップ
│   ├── starship.sh     # Starshipセットアップ
│   ├── ghostty.sh      # Ghosttyセットアップ
│   ├── zellij.sh       # Zellijセットアップ
│   ├── yazi.sh         # Yaziセットアップ
│   ├── waybar.sh       # Waybarセットアップ
│   └── fish.sh         # Fish Shellセットアップ
├── setup.sh            # メインセットアップスクリプト
└── README.md           # このファイル
```

## クイックスタート

### 新しい環境にセットアップする

1. このリポジトリをクローン：

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

2. セットアップスクリプトを実行：

```bash
# 対話モードで選択してセットアップ
./setup.sh

# すべてのツールを一括セットアップ
./setup.sh --all

# 特定のツールのみセットアップ
./setup.sh --nvim --starship
```

### セットアップオプション

```bash
./setup.sh [OPTIONS]

OPTIONS:
    -h, --help          ヘルプメッセージを表示
    -a, --all           全てのツールをセットアップ
    -n, --nvim          Neovimのみセットアップ
    -s, --starship      Starshipのみセットアップ
    -g, --ghostty       Ghosttyのみセットアップ
    -z, --zellij        Zellijのみセットアップ
    -y, --yazi          Yaziのみセットアップ
    -w, --waybar        Waybarのみセットアップ
    -f, --fish          Fish Shellのみセットアップ
```

### 個別のツールをセットアップ

各ツールのセットアップスクリプトは個別に実行することもできます：

```bash
# Neovimのみセットアップ
./scripts/nvim.sh

# Starshipのみセットアップ
./scripts/starship.sh

# Ghosttyのみセットアップ
./scripts/ghostty.sh

# Zellijのみセットアップ
./scripts/zellij.sh

# Yaziのみセットアップ
./scripts/yazi.sh

# Waybarのみセットアップ
./scripts/waybar.sh

# Fish Shellのみセットアップ
./scripts/fish.sh
```

## 各ツールの詳細

### Neovim

- LazyVimベースの設定
- プラグインは初回起動時に自動インストールされます
- 設定ファイル: `.config/nvim/`

インストール後の初回起動：
```bash
nvim
```

### Starship

- 高速でカスタマイズ可能なプロンプト
- 設定ファイル: `.config/starship.toml`

シェルの設定に以下を追加：
```bash
# Bash/Zsh
eval "$(starship init bash)"  # または zsh

# Fish
starship init fish | source
```

### Ghostty

- モダンなターミナルエミュレータ
- 設定ファイル: `.config/ghostty/config`

### Zellij

- Rustで書かれたターミナルマルチプレクサ
- 設定ファイル: `.config/zellij/config.kdl`

### Yazi

- Rustで書かれた高速なターミナルファイルマネージャ
- 設定ファイル: `.config/yazi/`
- プラグインは初回起動時に自動インストールされます

基本的な使い方：
```bash
yazi
```

### Waybar

- Wayland用の高度にカスタマイズ可能なステータスバー
- 設定ファイル: `.config/waybar/`
- Hyprlandなどのコンポジタで使用されます

### Fish Shell

- モダンで使いやすいシェル
- 設定ファイル: `.config/fish/`
- Fisherプラグインマネージャを使用

デフォルトシェルに設定：
```bash
chsh -s $(which fish)
```

プラグインを追加する場合：
```bash
fisher install <plugin-name>
```

## トラブルシューティング

### シンボリックリンクが既に存在する

セットアップスクリプトは既存のファイルを自動的にバックアップします。
バックアップファイルは `*.backup.YYYYMMDD_HHMMSS` という形式で保存されます。

### ツールがインストールされていない

セットアップスクリプトは可能な場合、自動的にツールのインストールを試みます。
インストールに失敗した場合は、各ツールの公式サイトから手動でインストールしてください：

- [Neovim](https://neovim.io/)
- [Starship](https://starship.rs/)
- [Ghostty](https://ghostty.org/)
- [Zellij](https://zellij.dev/)
- [Yazi](https://yazi-rs.github.io/)
- [Waybar](https://github.com/Alexays/Waybar)
- [Fish Shell](https://fishshell.com/)
- [Fisher](https://github.com/jorgebucaran/fisher)

## カスタマイズ

設定ファイルを編集した後、リポジトリにコミットしてください：

```bash
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push
```

## その他の設定

### Fish Shellプラグイン管理（Fisherを使用）

このdotfilesではFisherプラグインマネージャを使用しています。

プラグインのインストール：
```bash
# fish内で実行
fisher install jorgebucaran/fisher
fisher install <plugin-name>
```

インストール済みプラグインの確認：
```bash
fisher list
```

プラグインのバックアップと復元：
```bash
# バックアップ（fish_pluginsファイルが作成されます）
fisher list > ~/.config/fish/fish_plugins

# 復元（新しい環境で）
fisher update
```

## ライセンス

個人使用のための設定ファイルです。自由に利用・改変してください。
