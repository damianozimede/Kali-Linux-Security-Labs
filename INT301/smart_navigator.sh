#!/bin/bash

# smart_navigator.sh - Intelligent navigation with memory

NAVIGATION_HISTORY="$HOME/navigation_history.txt"

log_navigation() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local current_dir=$(pwd)
    echo "$timestamp | $current_dir" >> "$NAVIGATION_HISTORY"
    echo "📝 Navigation logged: $current_dir"
}

smart_cd() {
    local target_dir="$1"
    echo "🧭 Attempting to navigate to: $target_dir"
    if [ -d "$target_dir" ]; then
        cd "$target_dir"
        log_navigation
        echo "✅ Successfully navigated to: $(pwd)"
    else
        echo "❌ Error: Directory '$target_dir' does not exist"
        return 1
    fi
}

show_history() {
    echo "=== 🕐 Recent Navigation History ==="
    if [ -f "$NAVIGATION_HISTORY" ]; then
        tail -10 "$NAVIGATION_HISTORY"
    else
        echo "No navigation history found."
        echo "Start using smart_cd to build history!"
    fi
}


