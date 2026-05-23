#!/bin/bash

# Exercise 2: Bulk Ownership Change

directory="$1"
username="$2"

if [ -z "$directory" ] || [ -z "$username" ]; then
    echo "❌ Error: Missing arguments!"
    echo "   Usage: ./bulk_ownership.sh <directory> <username>"
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "❌ Error: Directory does not exist: $directory"
    exit 1
fi

echo "=========================================="
echo "👤 BULK OWNERSHIP CHANGE"
echo "=========================================="
echo "📁 Directory: $directory"
echo "👤 New owner: $username"
echo ""

chown -R "$username" "$directory"

if [ $? -eq 0 ]; then
    echo "✅ Ownership changed successfully!"
    echo ""
    echo "📋 Current ownership:"
    ls -l "$directory"
else
    echo "❌ Ownership change failed!"
fi

echo "=========================================="
echo "✅ Bulk ownership change complete!"
echo "=========================================="
