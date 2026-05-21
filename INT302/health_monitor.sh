#!/bin/bash

# health_monitor.sh - System health monitoring with alerts

check_disk_space() {
    local threshold="${1:-80}"
    echo "💾 Checking disk space..."
    
    local usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    
    if [ "$usage" -gt "$threshold" ]; then
        echo "⚠️  WARNING: Disk usage is at ${usage}% (threshold: ${threshold}%)"
    else
        echo "✅ Disk usage is OK: ${usage}% (threshold: ${threshold}%)"
    fi
}

check_memory() {
    local threshold="${1:-80}"
    echo "🧠 Checking memory usage..."
    
    local total=$(free | grep Mem | awk '{print $2}')
    local used=$(free | grep Mem | awk '{print $3}')
    local usage=$((used * 100 / total))
    
    if [ "$usage" -gt "$threshold" ]; then
        echo "⚠️  WARNING: Memory usage is at ${usage}% (threshold: ${threshold}%)"
    else
        echo "✅ Memory usage is OK: ${usage}% (threshold: ${threshold}%)"
    fi
}

check_service() {
    local service_name="$1"
    echo "🔍 Checking service: $service_name"
    
    if systemctl is-active --quiet "$service_name"; then
        echo "✅ Service is running: $service_name"
    else
        echo "⚠️  WARNING: Service is not running: $service_name"
    fi
}

run_health_check() {
    echo "=========================================="
    echo "🏥 SYSTEM HEALTH MONITOR"
    echo "=========================================="
    echo "🕐 Time: $(date)"
    echo ""
    
    check_disk_space 80
    echo ""
    check_memory 80
    echo ""
    check_service ssh
    check_service apache2
    echo ""
    
    echo "=========================================="
    echo "✅ Health check complete!"
    echo "=========================================="
}

run_health_check
