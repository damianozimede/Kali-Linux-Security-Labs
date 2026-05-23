#!/bin/bash

# file_manager.sh - Safe file operations with verification

create_secure_file() {
    local file_path="$1"
    local content="$2"
    local permissions="${3:-644}"
    
    echo "🛠️  Creating file: $file_path"
    
    local dir_path=$(dirname "$file_path")
    
    if [ ! -d "$dir_path" ]; then
        echo "📁 Creating directory structure: $dir_path"
        mkdir -p "$dir_path"
        
        if [ ! -d "$dir_path" ]; then
            echo "❌ Critical: Failed to create directory: $dir_path"
            return 1
        fi
    fi
    
    echo "$content" > "$file_path"
    
    chmod "$permissions" "$file_path"
    
    if [ -f "$file_path" ]; then
        local actual_perms=$(stat -c "%a" "$file_path")
        local file_size=$(stat -c "%s" "$file_path")
        
        echo "✅ File creation successful!"
        echo "   📍 Location: $file_path"
        echo "   🔐 Permissions: $actual_perms"
        echo "   📊 Size: $file_size bytes"
        echo "   📝 Content: '$content'"
        return 0
    else
        echo "❌ File creation failed: $file_path"
        return 1
    fi
}

safe_move() {
    local source="$1"
    local destination="$2"
    local backup_suffix=".backup.$(date +%Y%m%d_%H%M%S)"
    
    echo "🚚 Moving: $source → $destination"
    
    if [ ! -e "$source" ]; then
        echo "❌ Source does not exist: $source"
        return 1
    fi
    
    if [ ! -r "$source" ]; then
        echo "❌ Cannot read source file: $source"
        return 1
    fi
    
    if [ -e "$destination" ]; then
        echo "⚠️  Destination exists! Creating backup..."
        cp -r "$destination" "$destination$backup_suffix"
        
        if [ ! -e "$destination$backup_suffix" ]; then
            echo "❌ Backup creation failed! Aborting move."
            return 1
        fi
        echo "✅ Backup created: $destination$backup_suffix"
    fi
    
    mv "$source" "$destination"
    
    if [ -e "$destination" ] && [ ! -e "$source" ]; then
        echo "✅ Move operation successful!"
        echo "   📦 Source: $source"
        echo "   🎯 Destination: $destination"
        if [ -e "$destination$backup_suffix" ]; then
            echo "   💾 Backup: $destination$backup_suffix"
        fi
        return 0
    else
        echo "❌ Move operation failed!"
        echo "   Please check file permissions and disk space."
        return 1
    fi
}
