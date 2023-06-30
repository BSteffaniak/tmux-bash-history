#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

main() {
    local script_location="$SCRIPTS_DIR/restore_history.sh"
    local source_cmd=". $script_location"
    local rc_file="$HOME/.bashrc"

    if ! grep -q "$script_location" "$rc_file"; then
        {
            echo ""
            echo "# tmux-bash-history"
            echo "$source_cmd"
        } >>"$rc_file"
    fi
}
main
