#!/bin/bash
# Exercise 3: Automated ACL Management

directory="$1"
username="$2"

if [ -z "$directory" ] || [ -z "$username" ]; then
    echo "❌ Error: Missing arguments!"
    echo "   Usage: ./acl_management.sh <directory> <username>"
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "❌ Error: Directory does not exist: $directory"
    exit 1
fi

echo "=========================================="
echo "🔐 AUTOMATED ACL MANAGEMENT"
echo "=========================================="
echo "📁 Directory: $directory"
echo "👤 User: $username"
echo ""

echo "Setting default ACL for $username on $directory..."
setfacl -d -m u:$username:rx "$directory"
setfacl -m u:$username:rx "$directory"

echo ""
echo "✅ Default ACL set successfully!"
echo ""
echo "📋 Current ACL for $directory:"
getfacl "$directory"

echo "=========================================="
echo "✅ ACL management complete!"
echo "=========================================="
