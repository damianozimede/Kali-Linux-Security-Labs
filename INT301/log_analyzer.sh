#!/bin/bash

# log_analyzer.sh - Log file analysis and reporting

analyze_errors() {
    local log_file="$1"
    echo "🔍 Analyzing errors in: $log_file"
    
    if [ ! -f "$log_file" ]; then
        echo "❌ Log file not found: $log_file"
        return 1
    fi
    
    local error_count=$(grep -ci "error" "$log_file")
    local warning_count=$(grep -ci "warning" "$log_file")
    local critical_count=$(grep -ci "critical" "$log_file")
    
    echo ""
    echo "📊 Log Analysis Summary:"
    echo "   ❌ Errors found: $error_count"
    echo "   ⚠️  Warnings found: $warning_count"
    echo "   🚨 Critical issues: $critical_count"
}

generate_report() {
    local log_file="$1"
    local report_file="$HOME/log_report_$(date +%Y%m%d_%H%M%S).txt"
    
    echo "📝 Generating report..."
    
    {
        echo "=========================================="
        echo "📋 LOG ANALYSIS REPORT"
        echo "=========================================="
        echo "🕐 Generated: $(date)"
        echo "📁 Log file: $log_file"
        echo ""
        analyze_errors "$log_file"
        echo ""
        echo "🔝 Last 10 error lines:"
        grep -i "error" "$log_file" | tail -10
        echo "=========================================="
    } > "$report_file"
    
    echo "✅ Report saved to: $report_file"
}

archive_log() {
    local log_file="$1"
    local archive_dir="$HOME/log_archives"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    if [ ! -d "$archive_dir" ]; then
        mkdir -p "$archive_dir"
    fi
    
    cp "$log_file" "$archive_dir/$(basename $log_file)_$timestamp"
    echo "📦 Log archived to: $archive_dir"
}

# Main program
echo "=========================================="
echo "📋 LOG FILE ANALYZER"
echo "=========================================="

log_file="${1:-/var/log/syslog}"

analyze_errors "$log_file"
echo ""
generate_report "$log_file"
echo ""
archive_log "$log_file"
echo ""
echo "✅ Log analysis complete!"

