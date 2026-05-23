#!/bin/bash


scan_port() {
    local host=$1
    local port=$2
    if timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null; then
        echo "Port $port: OPEN"
    fi
}

simple_port_scanner() {
    echo "=== Simple Port Scanner ==="
    echo -n "Enter target IP or hostname: "
    read target
    echo -n "Enter start port: "
    read start_port
    echo -n "Enter end port: "
    read end_port
    echo "Scanning $target from port $start_port to $end_port"
    echo "========================================="
    for ((port=start_port; port<=end_port; port++)); do
        scan_port $target $port
    done
    echo "Scan complete!"
}

simple_port_scanner
