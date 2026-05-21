#!/bin/bash


# backup_system.sh - Automated backup with rotation

create_backup() {
    local source_dir="$1"
    local backup_dir="$2"
    local max_backups="${3:-5}"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$backup_dir/backup_$timestamp.tar.gz"
    
    echo "🔄 Starting backup process..."
    
    # Check if source directory exists
    if [ ! -d "$source_dir" ]; then
        echo "❌ Source directory does not exist: $source_dir"
        return 1
    fi
    
    # Create backup directory if needed
    if [ ! -d "$backup_dir" ]; then
        echo "📁 Creating backup directory: $backup_dir"
        mkdir -p "$backup_dir"
    fi
    
    # Create compressed backup
    echo "📦 Compressing: $source_dir"
    tar -czf "$backup_file" "$source_dir" 2>/dev/null
    
    # Verify the backup
    if [ -f "$backup_file" ]; then
        local size=$(stat -c "%s" "$backup_file")
        echo "✅ Backup created successfully!"
        echo "   📍 Location: $backup_file"
        echo "   📊 Size: $size bytes"
    else
        echo "❌ Backup failed!"
        return 1
    fi
    
    # Clean up old backups beyond max_backups
    echo "🧹 Cleaning old backups (keeping last $max_backups)..."
    ls -t "$backup_dir"/backup_*.tar.gz 2>/dev/null | tail -n +$((max_backups + 1)) | xargs rm -f
    
    echo "✅ Backup process complete!"
}

# Main program
echo "=========================================="
echo "💾 AUTOMATED BACKUP SYSTEM"
echo "=========================================="

create_backup "$1" "$2" "$3"
