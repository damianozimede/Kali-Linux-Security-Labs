#!/bin/bash
# Advanced Reconnaissance Framework
# Usage: ./advanced_recon.sh <domain>

DOMAIN="$1"
OUTPUT_DIR="recon_${DOMAIN}_$(date +%Y%m%d_%H%M%S)"
COMPREHENSIVE_REPORT="${OUTPUT_DIR}/comprehensive_report.txt"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "🎯 Advanced Reconnaissance Framework" | tee "$COMPREHENSIVE_REPORT"
echo "Target: $DOMAIN" | tee -a "$COMPREHENSIVE_REPORT"
echo "Date: $(date)" | tee -a "$COMPREHENSIVE_REPORT"
echo "==========================================" | tee -a "$COMPREHENSIVE_REPORT"

advanced_ping_analysis() {
    echo "🔍 Advanced Ping Analysis" | tee -a "$COMPREHENSIVE_REPORT"
    echo "----------------------------------------" | tee -a "$COMPREHENSIVE_REPORT"
    
    local ping_file="${OUTPUT_DIR}/ping_analysis.txt"
    ping -c 10 "$DOMAIN" > "$ping_file"
    
    local avg_ping=$(grep "avg" "$ping_file" | awk -F'/' '{print $5}')
    local packet_loss=$(grep "packet loss" "$ping_file" | awk '{print $6}')
    
    echo "📊 Network Statistics:" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  Average RTT: $avg_ping ms" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  Packet Loss: $packet_loss" | tee -a "$COMPREHENSIVE_REPORT"
    echo "" | tee -a "$COMPREHENSIVE_REPORT"
}

comprehensive_dns_scan() {
    echo "🌐 Comprehensive DNS Analysis" | tee -a "$COMPREHENSIVE_REPORT"
    echo "----------------------------------------" | tee -a "$COMPREHENSIVE_REPORT"
    
    local dns_file="${OUTPUT_DIR}/dns_records.txt"
    
    for record in A AAAA MX TXT NS SOA CNAME; do
        echo "📝 $record Records:" | tee -a "$COMPREHENSIVE_REPORT"
        dig "$DOMAIN" $record +short | tee -a "$COMPREHENSIVE_REPORT" | tee -a "$dns_file"
        echo "" | tee -a "$COMPREHENSIVE_REPORT"
    done
    
    echo "🛡️ DNS Blacklist Check:" | tee -a "$COMPREHENSIVE_REPORT"
    local domain_ip=$(dig +short "$DOMAIN" | head -1)
    echo "Checking IP $domain_ip against blacklists..." | tee -a "$COMPREHENSIVE_REPORT"
    echo "" | tee -a "$COMPREHENSIVE_REPORT"
}

generate_summary() {
    echo "📈 Reconnaissance Summary" | tee -a "$COMPREHENSIVE_REPORT"
    echo "----------------------------------------" | tee -a "$COMPREHENSIVE_REPORT"
    
    local ip_count=$(dig "$DOMAIN" A +short | wc -l)
    local mx_count=$(dig "$DOMAIN" MX +short | wc -l)
    local ns_count=$(dig "$DOMAIN" NS +short | wc -l)
    
    echo "📊 Infrastructure Overview:" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  IP Addresses: $ip_count" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  Mail Servers: $mx_count" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  Name Servers: $ns_count" | tee -a "$COMPREHENSIVE_REPORT"
    echo "" | tee -a "$COMPREHENSIVE_REPORT"
    
    echo "💡 Security Observations:" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  - Check for SPF/DKIM/DMARC records in TXT" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  - Verify name server security" | tee -a "$COMPREHENSIVE_REPORT"
    echo "  - Analyze subdomain structure" | tee -a "$COMPREHENSIVE_REPORT"
    echo "" | tee -a "$COMPREHENSIVE_REPORT"
}

main() {
    if [ -z "$DOMAIN" ]; then
        echo "Usage: $0 <domain>"
        exit 1
    fi
    
    echo "🚀 Starting comprehensive reconnaissance..." | tee -a "$COMPREHENSIVE_REPORT"
    echo "" | tee -a "$COMPREHENSIVE_REPORT"
    
    advanced_ping_analysis
    comprehensive_dns_scan
    generate_summary
    
    echo "✅ Reconnaissance complete!" | tee -a "$COMPREHENSIVE_REPORT"
    echo "📁 Results saved in: $OUTPUT_DIR" | tee -a "$COMPREHENSIVE_REPORT"
    echo "📄 Main report: $COMPREHENSIVE_REPORT" | tee -a "$COMPREHENSIVE_REPORT"
}

main "$@"
