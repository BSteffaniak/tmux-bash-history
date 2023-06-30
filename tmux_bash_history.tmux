#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

main() {
    local script_location="$SCRIPTS_DIR/restore_history.sh"
    local source_cmd="[ -f \"$script_location\" ] && . $script_location"
    local rc_file="$HOME/.bashrc"

    if ! grep -q "$script_location" "$rc_file"; then
        {
            echo ""
            echo "# tmux-bash-history"
            echo "if [[ -n \"\$TMUX\" ]]; then"
            echo "    # Optionally set a custom bash history home directory:"
            echo "    # tmux set -g @bash-history-home \"~/path/to/custom/dir\""
            echo "    $source_cmd"
            echo "fi"
        } >>"$rc_file"
    fi
}
main
