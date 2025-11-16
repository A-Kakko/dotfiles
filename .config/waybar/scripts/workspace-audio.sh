#!/bin/bash

# 音を出しているアプリケーションのマッピング（バイナリ名 -> アイコン）
declare -A APP_ICONS=(
    ["spotify"]="🎵"
    ["firefox"]="🎬"
    ["vivaldi"]="🎬"
    ["vivaldi-bin"]="🎬"
    ["chromium"]="🎬"
    ["chrome"]="🎬"
    ["google-chrome"]="🎬"
    ["mpv"]="🎬"
    ["vlc"]="🎬"
    ["discord"]="🎙️"
    ["telegram"]="🎙️"
    ["slack"]="🎙️"
)

# バイナリ名からHyprlandのクラス名へのマッピング
declare -A BINARY_TO_CLASS=(
    ["vivaldi-bin"]="vivaldi-stable"
    ["spotify"]="Spotify"
)

# 音を出しているアプリを取得（バイナリ名）
playing_apps=$(pactl list sink-inputs | grep "application.process.binary" | \
    sed 's/.*= "\(.*\)"/\1/' | sort -u)

# Hyprlandのクライアント情報を取得
clients=$(hyprctl clients -j)

# ワークスペースごとの音アイコンを格納
declare -A workspace_icons

# 音を出しているアプリを処理
while read -r app; do
    [[ -z "$app" ]] && continue

    # アプリ名を正規化（パスを削除）
    app_name=$(basename "$app")

    # アイコンを取得
    icon="${APP_ICONS[$app_name]}"
    [[ -z "$icon" ]] && icon="🔊"

    # バイナリ名をHyprlandクラス名に変換
    class_name="${BINARY_TO_CLASS[$app_name]}"
    [[ -z "$class_name" ]] && class_name="$app_name"

    # このアプリがいるワークスペースを取得
    workspace=$(echo "$clients" | jq -r --arg class "$class_name" \
        '.[] | select(.class | contains($class)) | .workspace.id' | head -1)

    # ワークスペースが見つかったら記録
    if [[ -n "$workspace" && "$workspace" != "null" ]]; then
        workspace_icons[$workspace]="$icon"
    fi
done <<< "$playing_apps"

# JSONフォーマットで出力（waybarが読み込める形式）
echo -n "{"
first=true
for ws in "${!workspace_icons[@]}"; do
    if [ "$first" = true ]; then
        first=false
    else
        echo -n ","
    fi
    echo -n "\"$ws\":\"${workspace_icons[$ws]}\""
done
echo "}"
