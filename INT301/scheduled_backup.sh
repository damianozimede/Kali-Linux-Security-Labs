#!/bin/bash
# Exercise 4: Scheduled Backup Script

directory="$1"
backup_dir="$HOME/backups"
date_stamp=$(date +%Y-%m-%d)
backup_file="$backup_dir/backup_$date_stamp.tar.gz"

if [ -z "$directory" ]; then
    echo "❌ Error: No directory specified!"
    echo "   Usage: ./scheduled_backup.sh <directory>"
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "❌ Error: Directory does not exist: $directory"
    exit 1
fi

echo "=========================================="
echo "💾 SCHEDULED BACKUP SCRIPT"
echo "=========================================="
echo "📁 Source: $directory"
echo "💾 Backup: $backup_file"
echo ""

if [ ! -d "$backup_dir" ]; then
    echo "📁 Creating backup directory: $backup_dir"
    mkdir -p "$backup_dir"
fi

echo "🔄 Creating backup..."
tar -czvf "$backup_file" "$directory" --preserve-permissions 2>/dev/null

if [ -f "$backup_file" ]; then
    local_size=$(stat -c "%s" "$backup_file")
    echo "✅ Backup created successfully!"
    echo "   📍 Location: $backup_file"
    echo "   📊 Size: $local_size bytes"
else
    echo "❌ Backup failed!"
    exit 1
fi

echo ""
echo "=========================================="
echo "✅ Backup complete!"
echo "=========================================="
