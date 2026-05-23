#!/bin/bash

# Exercise 1: Automated Permission Checker

directory="$1"

if [ -z "$directory" ]; then
    echo "❌ Error: No directory specified!"
    echo "   Usage: ./permission_checker.sh <directory>"
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "❌ Error: Directory does not exist: $directory"
    exit 1
fi

echo "=========================================="
echo "🔍 PERMISSION CHECKER"
echo "=========================================="
echo "📁 Checking directory: $directory"
echo ""

for file in "$directory"/*; do
    if [ -f "$file" ]; then
        if [ ! -x "$file" ]; then
            echo "⚠️  Missing execute permission: $file"
            chmod u+x "$file"
            echo "✅ Execute permission added: $file"
        else
            echo "✅ Execute permission OK: $file"
        fi
    fi
done

echo ""
echo "=========================================="
echo "✅ Permission check complete!"
echo "=========================================="
