#!/bin/bash
get_system_info() {
    echo "=== System Information ==="
    echo "Current user: $(whoami)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Date: $(date)"
    echo
}

get_disk_space() {
    echo "=== Disk Space ==="
    df -h | grep -v tmpfs
    echo
}

get_memory_usage() {
    echo "=== Memory Usage ==="
    free -h
    echo
}

get_top_processes() {
    echo "=== Top 5 Processes by CPU ==="
    ps aux --sort=-%cpu | head -6
    echo
}

get_network_connections() {
    echo "=== Network Connections ==="
    ss -tuln
    echo
}

monitor_system() {
    clear
    echo "System Monitor - $(date)"
    echo "=========================="
    echo
    get_system_info
    get_disk_space
    get_memory_usage
    get_top_processes
    get_network_connections
    echo "Monitoring complete!"
}

monitor_system
