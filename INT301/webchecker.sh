#!/bin/bash

echo "=== Website Status Checker ==="
sites="google.com github.com kali.org"

for site in $sites; do
    if ping -c 1 -W 2 $site &>/dev/null; then
        echo "$site: ONLINE ✓"
    else
        echo "$site: OFFLINE ✗"
    fi
done
