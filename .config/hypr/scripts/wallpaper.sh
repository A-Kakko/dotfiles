#!/bin/bash

WALLPAPER_DIR="$HOME/Wallpapers"  # 壁紙フォルダのパス
INTERVAL=600  # 切り替え間隔（秒）デフォルト10分

# ランダムな壁紙を選択して設定
while true; do
    #pkill swaybg
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
    swww img "$WALLPAPER" --transition-type random --transition-duration 2
    sleep $INTERVAL
done
