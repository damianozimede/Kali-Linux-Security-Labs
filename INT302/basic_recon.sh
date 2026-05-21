#!/bin/bash
# Basic Reconnaissance Script
# Usage: ./basic_recon.sh <domain>

DOMAIN="$1"
LOG_FILE="recon_${DOMAIN}_$(date +%Y%m%d_%H%M%S).txt"

echo "🎯 Starting Basic Reconnaissance for: $DOMAIN" | tee "$LOG_FILE"
echo "==========================================" | tee -a "$LOG_FILE"

# Function to perform ping analysis
ping_analysis() {
    echo "🔍 Ping Analysis for $DOMAIN" | tee -a "$LOG_FILE"
    echo "----------------------------------------" | tee -a "$LOG_FILE"
    
    if ping -c 4 "$DOMAIN" > /dev/null 2>&1; then
        echo "✅ Target is reachable" | tee -a "$LOG_FILE"
        ping -c 4 "$DOMAIN" | tee -a "$LOG_FILE"
        
        # Extract IP address from ping
        IP_ADDRESS=$(ping -c 1 "$DOMAIN" | head -1 | cut -d'(' -f2 | cut -d')' -f1)
        echo "📡 IP Address: $IP_ADDRESS" | tee -a "$LOG_FILE"
    else
        echo "❌ Target is not reachable via ICMP" | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"
}

ping_analysis "$DOMAIN"

# Function to perform whois analysis
whois_analysis() {
    local domain="$1"
    echo "📋 WHOIS Analysis for $domain" | tee -a "$LOG_FILE"
    echo "----------------------------------------" | tee -a "$LOG_FILE"
    
    if command -v whois >/dev/null 2>&1; then
        echo "📍 Registrar Information:" | tee -a "$LOG_FILE"
        whois "$domain" | grep -i "registrar" | head -5 | tee -a "$LOG_FILE"
        
        echo "" | tee -a "$LOG_FILE"
        echo "📅 Dates Information:" | tee -a "$LOG_FILE"
        whois "$domain" | grep -E -i "(creation date|expiration|updated)" | head -5 | tee -a "$LOG_FILE"
        
        echo "" | tee -a "$LOG_FILE"
        echo "🌍 Contact Information:" | tee -a "$LOG_FILE"
        whois "$domain" | grep -E -i "(country|state|email)" | head -5 | tee -a "$LOG_FILE"
        
        echo "" | tee -a "$LOG_FILE"
        echo "🔗 Name Servers:" | tee -a "$LOG_FILE"
        whois "$domain" | grep -i "name server" | head -10 | tee -a "$LOG_FILE"
    else
        echo "❌ whois command not available" | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"
}

whois_analysis "$DOMAIN"

# Function to perform DNS analysis
dns_analysis() {
    local domain="$1"
    echo "🌐 DNS Analysis for $domain" | tee -a "$LOG_FILE"
    echo "----------------------------------------" | tee -a "$LOG_FILE"
    
    echo "📍 A Records (IPv4):" | tee -a "$LOG_FILE"
    dig "$domain" A +short | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "🔷 AAAA Records (IPv6):" | tee -a "$LOG_FILE"
    dig "$domain" AAAA +short | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "📧 MX Records (Mail Servers):" | tee -a "$LOG_FILE"
    dig "$domain" MX +short | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "📝 TXT Records:" | tee -a "$LOG_FILE"
    dig "$domain" TXT +short | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "🔗 NS Records (Name Servers):" | tee -a "$LOG_FILE"
    dig "$domain" NS +short | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "🔄 CNAME Records:" | tee -a "$LOG_FILE"
    dig "$domain" CNAME +short | tee -a "$LOG_FILE"
}

dns_analysis "$DOMAIN"
