#!/bin/env sh
TMP_FILE="$XDG_RUNTIME_DIR/hyprland-show-desktop"
CURRENT_WORKSPACE=$(hyprctl monitors -j | jq '.[] | .activeWorkspace | .name' | sed 's/"//g')

if [ -s "$TMP_FILE-$CURRENT_WORKSPACE" ]; then
    # ウィンドウを戻す
    readarray -d $'\n' -t ADDRESS_ARRAY <<< $(< "$TMP_FILE-$CURRENT_WORKSPACE")
    for address in "${ADDRESS_ARRAY[@]}"
    do
        CMDS+="dispatch movetoworkspacesilent name:$CURRENT_WORKSPACE,address:$address;"
    done
    hyprctl --batch "$CMDS"
    rm "$TMP_FILE-$CURRENT_WORKSPACE"
else
    # ウィンドウを隠す
    HIDDEN_WINDOWS=$(hyprctl clients -j | jq -r --arg workspace "$CURRENT_WORKSPACE" '.[] | select(.workspace.name == $workspace) | .address')
    for address in $HIDDEN_WINDOWS
    do
        hyprctl dispatch movetoworkspacesilent special:desktop,address:$address
    done
    echo "$HIDDEN_WINDOWS" > "$TMP_FILE-$CURRENT_WORKSPACE"
fi
