#!/bin/bash
# Passive Intelligence Gathering Script
# Usage: ./passive_intel.sh <domain>

DOMAIN="$1"
PASSIVE_LOG="passive_intel_${DOMAIN}_$(date +%Y%m%d_%H%M%S).txt"

echo "🕵️ Passive Intelligence Gathering for: $DOMAIN" | tee "$PASSIVE_LOG"
echo "==========================================" | tee -a "$PASSIVE_LOG"

# Function to run theHarvester
run_theharvester() {
    echo "🔍 Running theHarvester..." | tee -a "$PASSIVE_LOG"
    echo "----------------------------------------" | tee -a "$PASSIVE_LOG"
    
    if command -v theHarvester >/dev/null 2>&1; then
        theHarvester -d "$DOMAIN" -l 100 -b rapiddns
        echo "✅ theHarvester completed." | tee -a "$PASSIVE_LOG"
    else
        echo "❌ theHarvester not installed" | tee -a "$PASSIVE_LOG"
    fi
    echo "" | tee -a "$PASSIVE_LOG"
}

run_theharvester "$DOMAIN"
