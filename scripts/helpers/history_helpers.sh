#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/tmux_helpers.sh"

bash_history_home_option="@bash-history-home"
default_bash_history_home="$HOME/.bash_history.d"
bash_history_home="$(get_tmux_option "$bash_history_home_option" "$default_bash_history_home")"

function getSanitizedFileName() {
    local pane_id=$1
    local session_name=$2
    local window_name=$3
    local window_number=$4
    local pane_index=$5

    [[ -z $session_name ]] && session_name=$(tmux display-message -t "$pane_id" -p '#S')
    [[ -z $window_name ]] && window_name=$(tmux display-message -t "$pane_id" -p '#W')
    [[ -z $window_number ]] && window_number=$(tmux display-message -t "$pane_id" -p '#I')
    [[ -z $pane_index ]] && pane_index=$(tmux display-message -t "$pane_id" -p '#P')

    COUNT=$(tmux lsw -t "$pane_id" -F '#W' | grep -c "^${window_name}\$")

    if ((COUNT == "1")); then
        FILENAME="${session_name}:${window_name}:${pane_index}"
    else
        FILENAME="${session_name}:${window_name}:${window_number}:${pane_index}"
    fi

    echo "${FILENAME// /_}"
}

function getHistFile() {
    local pane_id=$1
    local session_name=$2
    local window_name=$3
    local window_number=$4
    local pane_index=$5

    if [ -n "${pane_id}" ]; then
        echo "${bash_history_home}/bash_history_tmux_$(getSanitizedFileName "$pane_id" "$session_name" "$window_name" "$window_number" "$pane_index")"
    else
        echo "${bash_history_home}/bash_history_no_tmux"
    fi
}

function getCmdFile() {
    local pane_id=$1
    local session_name=$2
    local window_name=$3
    local window_number=$4
    local pane_index=$5

    if [ -n "${pane_id}" ]; then
        echo "${bash_history_home}/bash_cmd_tmux_$(getSanitizedFileName "$pane_id" "$session_name" "$window_name" "$window_number" "$pane_index")"
    else
        echo "${bash_history_home}/bash_cmd_no_tmux"
    fi
}
