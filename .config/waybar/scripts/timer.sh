#!/bin/bash
# ~/.config/waybar/scripts/timer.sh

TIMER_FILE="/tmp/waybar_timer"
PID_FILE="/tmp/waybar_timer.pid"

case "$1" in
    start)
        if [ -f "$PID_FILE" ]; then
            echo "タイマーは既に実行中です"
            exit 1
        fi
        
        time=$(echo "" | rofi -dmenu -p "タイマー時間 (例: 25m, 5s):")
        [ -z "$time" ] && exit 0
        
        message=$(echo "" | rofi -dmenu -p "メッセージ (オプション):")
        [ -z "$message" ] && message="タイマー終了！"
        
        # タイマー情報を保存
        echo "$time|$message|$(date +%s)" > "$TIMER_FILE"
        
        # バックグラウンドでタイマー実行
        # 環境変数を保存
        DBUS_ADDR="$DBUS_SESSION_BUS_ADDRESS"
        DISPLAY_VAR="$DISPLAY"
        WAYLAND_DISPLAY_VAR="$WAYLAND_DISPLAY"
        XDG_RUNTIME_DIR_VAR="$XDG_RUNTIME_DIR"

        (
            export DBUS_SESSION_BUS_ADDRESS="$DBUS_ADDR"
            export DISPLAY="$DISPLAY_VAR"
            export WAYLAND_DISPLAY="$WAYLAND_DISPLAY_VAR"
            export XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR_VAR"

            sleep "$time"
            notify-send -u critical "⏰ タイマー" "$message"
            paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga 2>/dev/null
            rm -f "$TIMER_FILE" "$PID_FILE"
        ) &
        
        echo $! > "$PID_FILE"
        ;;
        
    stop)
        if [ -f "$PID_FILE" ]; then
            kill $(cat "$PID_FILE") 2>/dev/null
            rm -f "$TIMER_FILE" "$PID_FILE"
            notify-send "⏰ タイマー" "キャンセルしました"
        fi
        ;;
        
    status)
        if [ -f "$TIMER_FILE" ] && [ -f "$PID_FILE" ]; then
            read -r data < "$TIMER_FILE"
            IFS='|' read -r duration message start_time <<< "$data"
            
            # 残り時間を計算
            current=$(date +%s)
            elapsed=$((current - start_time))
            
            # durationを秒に変換（簡易版）
            if [[ $duration =~ ^([0-9]+)m$ ]]; then
                total_seconds=$((${BASH_REMATCH[1]} * 60))
            elif [[ $duration =~ ^([0-9]+)s$ ]]; then
                total_seconds=${BASH_REMATCH[1]}
            elif [[ $duration =~ ^([0-9]+)h$ ]]; then
                total_seconds=$((${BASH_REMATCH[1]} * 3600))
            else
                total_seconds=0
            fi
            
            remaining=$((total_seconds - elapsed))
            
            if [ $remaining -gt 0 ]; then
                mins=$((remaining / 60))
                secs=$((remaining % 60))
                printf '{"text": "⏱ %02d:%02d", "tooltip": "%s", "class": "active"}' $mins $secs "$message"
            else
                echo '{"text": "", "class": "idle"}'
            fi
        else
            echo '{"text": "", "class": "idle"}'
        fi
        ;;
esac
