#!/bin/bash

# 音を出しているアプリケーションのマッピング
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

# デフォルトのワークスペースアイコン
declare -A DEFAULT_ICONS=(
    [1]="Ⅰ"
    [2]="Ⅱ"
    [3]="Ⅲ"
    [4]="Ⅳ"
    [5]="Ⅴ"
    [6]="Ⅵ"
    [7]="Ⅶ"
    [8]="Ⅷ"
    [9]="Ⅸ"
    [10]="Ⅹ"
)

# 前回の状態を保存
declare -A last_state

while true; do
    # 現在の音アイコン状態を取得
    declare -A workspace_icons

    # 音を出しているアプリを取得（PIDとバイナリ名）
    audio_streams=$(pactl list sink-inputs | \
        awk '/Sink Input #/{input=$3} /application.process.id/{pid=$3; gsub(/"/, "", pid)} /application.process.binary/{bin=$3; gsub(/"/, "", bin); print pid"|"bin}')

    # Hyprlandのクライアント情報
    clients=$(hyprctl clients -j)

    # 音を出しているアプリを処理
    while IFS='|' read -r pid app_binary; do
        [[ -z "$pid" || -z "$app_binary" ]] && continue

        app_name=$(basename "$app_binary")
        icon="${APP_ICONS[$app_name]}"
        [[ -z "$icon" ]] && icon="🔊"

        # プロセスの親PIDを取得（ブラウザなどはマルチプロセス）
        parent_pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
        [[ -z "$parent_pid" ]] && parent_pid="$pid"

        class_name="${BINARY_TO_CLASS[$app_name]}"
        [[ -z "$class_name" ]] && class_name="$app_name"

        # PIDまたは親PIDでワークスペースを検索
        workspace=$(echo "$clients" | jq -r --arg pid "$pid" --arg ppid "$parent_pid" --arg class "$class_name" \
            '.[] | select((.pid == ($pid|tonumber)) or (.pid == ($ppid|tonumber)) or (.class | contains($class))) | .workspace.id' | head -1)

        if [[ -n "$workspace" && "$workspace" != "null" && "$workspace" =~ ^-?[0-9]+$ ]]; then
            workspace_icons[$workspace]="$icon"
        fi
    done <<< "$audio_streams"

    # 存在するワークスペースを取得
    existing_workspaces=$(hyprctl workspaces -j | jq -r '.[] | select(.id > 0 and .id <= 10) | .id')

    # 存在するワークスペースのみ更新
    while read -r ws; do
        [[ -z "$ws" ]] && continue

        default_name="${DEFAULT_ICONS[$ws]}"

        if [[ -n "${workspace_icons[$ws]}" ]]; then
            new_name="${workspace_icons[$ws]} ${default_name}"
        else
            new_name="$default_name"
        fi

        # 状態が変わった場合のみ更新
        if [[ "${last_state[$ws]}" != "$new_name" ]]; then
            hyprctl dispatch renameworkspace "$ws" "$new_name" 2>/dev/null
            last_state[$ws]="$new_name"
        fi
    done <<< "$existing_workspaces"

    # 1秒待機
    sleep 1
done
