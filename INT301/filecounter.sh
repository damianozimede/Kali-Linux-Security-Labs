#!/bin/bash


echo "Enter directory path (or press Enter for current):"
read dir
dir=${dir:-.}
count=$(ls -1 "$dir" | wc -l)
echo "Number of files in $dir: $count"
