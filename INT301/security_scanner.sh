#!/bin/bash


LOG_FILE="security_scan_$(date +%Y%m%d_%H%M%S).log"

log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" | tee -a "$LOG_FILE"
}

network_discovery() {
    log "Starting network discovery..."
    local_ip=$(hostname -I | awk '{print $1}')
    log "Local IP: $local_ip"
    log "Discovering hosts on network..."
    nmap -sn "${local_ip%.*}.0/24" | grep "Nmap scan" | awk '{print $5, $6}' | tee -a "$LOG_FILE"
}

vulnerability_check() {
    log "Checking for vulnerabilities..."
    log "Checking for outdated packages..."
    apt list --upgradable 2>/dev/null | head -10 | tee -a "$LOG_FILE"
    log "Checking sudo version..."
    sudo --version | head -1 | tee -a "$LOG_FILE"
}

system_security_check() {
    log "Performing system security check..."
    log "Checking running services..."
    ss -tuln | grep LISTEN | tee -a "$LOG_FILE"
    log "Checking firewall status..."
    sudo iptables -L | tee -a "$LOG_FILE"
    log "Checking top processes..."
    ps aux --sort=-%cpu | head -10 | tee -a "$LOG_FILE"
}

main() {
    echo "=== Comprehensive Security Scanner ==="
    echo "Log file: $LOG_FILE"
    echo
    log "Security scan started"
    network_discovery
    vulnerability_check
    system_security_check
    log "Security scan completed"
    echo
    echo "Scan complete! Check $LOG_FILE for details."
}

main
send_alert() {
    log "CRITICAL ALERT: Security issues detected!"
    log "Upgradable packages found - patching required"
    echo "Email notification simulated - would send to admin@system.com"
}
