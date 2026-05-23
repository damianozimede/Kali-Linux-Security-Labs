#!/bin/bash

# automation_dashboard.sh - User-friendly automation interface

source smart_navigator.sh 2>/dev/null || echo "Note: smart_navigator.sh not found"
source file_manager.sh 2>/dev/null || echo "Note: file_manager.sh not found"

show_main_menu() {
    echo "=========================================="
    echo "🤖 LINUX AUTOMATION DASHBOARD"
    echo "=========================================="
    echo ""
    echo "Navigation Tools:"
    echo "  1. 📂 Smart Navigation"
    echo "  2. 🕐 View Navigation History"
    echo ""
    echo "File Operations:"
    echo "  3. 🛠️  Create Secure File"
    echo "  4. 🚚 Safe File Move"
    echo "  5. 📊 System Information"
    echo ""
    echo "Utilities:"
    echo "  6. 🧹 Clean Temporary Files"
    echo "  7. 💾 Quick Backup"
    echo "  0. ❌ Exit"
    echo ""
    echo "=========================================="
}

handle_menu_selection() {
    local choice
    read -p "Enter your choice [0-7]: " choice
    
    case $choice in
        1)
            smart_navigation_menu
            ;;
        2)
            show_history
            pause
            ;;
        3)
            file_creation_menu
            ;;
        4)
            file_move_menu
            ;;
        5)
            show_system_info
            pause
            ;;
        6)
            cleanup_menu
            ;;
        7)
            backup_menu
            ;;
        0)
            echo "👋 Thank you for using Automation Dashboard!"
            exit 0
            ;;
        *)
            echo "❌ Invalid option. Please try again."
            pause
            ;;
    esac
}

pause() {
    read -p "Press [Enter] to continue..."
}

smart_navigation_menu() {
    clear
    echo "=========================================="
    echo "📂 SMART NAVIGATION MENU"
    echo "=========================================="
    echo ""
    echo "Current directory: $(pwd)"
    echo ""
    
    local target_dir
    read -p "Enter directory path to navigate to: " target_dir
    
    if [ -n "$target_dir" ]; then
        smart_cd "$target_dir"
    else
        echo "❌ No directory specified."
    fi
    
    pause
}

file_creation_menu() {
    clear
    echo "=========================================="
    echo "🛠️  SECURE FILE CREATION"
    echo "=========================================="
    echo ""
    
    local file_path
    local content
    local permissions
    
    read -p "Enter file path: " file_path
    read -p "Enter file content: " content
    read -p "Enter permissions (default 644): " permissions
    
    if [ -z "$permissions" ]; then
        permissions="644"
    fi
    
    create_secure_file "$file_path" "$content" "$permissions"
    pause
}

show_system_info() {
    clear
    echo "=========================================="
    echo "📊 SYSTEM INFORMATION"
    echo "=========================================="
    echo ""
    
    echo "💻 Hostname: $(hostname)"
    echo "🤵 Current User: $(whoami)"
    echo "📁 Working Directory: $(pwd)"
    echo ""
    
    echo "💾 Disk Usage:"
    df -h / | tail -1
    echo ""
    
    echo "🧠 Memory Usage:"
    free -h | head -2
    echo ""
    
    echo "📈 System Uptime:"
    uptime
}

main() {
    if ! command -v smart_cd &> /dev/null; then
        echo "⚠️  Warning: Some functions not loaded properly"
        echo "   Make sure smart_navigator.sh and file_manager.sh are available"
        pause
    fi
    
    while true; do
        show_main_menu
        handle_menu_selection
    done
}

main
