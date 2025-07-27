#!/bin/bash

# Check if a file was provided
if [[ -z "$1" ]]; then
  echo "Usage: $0 <movie_filename>"
  exit 1
fi

file="$1"

# Check that file exists
if [[ ! -f "$file" ]]; then
  echo "File not found: $file"
  exit 1
fi

# Get extension and filename without path
basename=$(basename "$file")
extension="${basename##*.}"
filename="${basename%.*}"

# Convert to lowercase and replace spaces/periods with underscores
cleaned=$(echo "$filename" | tr '[:upper:]' '[:lower:]' | sed 's/[ .]/_/g')

# Remove resolution-like tokens (1080p, 720p, etc.) early
cleaned=$(echo "$cleaned" | sed -E 's/_[0-9]{3,4}p(_|$)/_/g')

# Remove consecutive and trailing underscores
cleaned=$(echo "$cleaned" | sed -E 's/_+/_/g' | sed -E 's/^_|_$//g')

# Try to extract title and a 4-digit year not part of resolution
if [[ $cleaned =~ ^(.+)_([12][0-9]{3})$ ]]; then
  title="${BASH_REMATCH[1]}"
  year="${BASH_REMATCH[2]}"
elif [[ $cleaned =~ ^(.+)_([12][0-9]{3})_ ]]; then
  title="${BASH_REMATCH[1]}"
  year="${BASH_REMATCH[2]}"
else
  echo "Could not extract valid title/year from: $file"
  exit 1
fi

newname="${title}_${year}.${extension}"

# Rename if different
if [[ "$basename" != "$newname" ]]; then
  echo "Renaming: $basename → $newname"
  mv -i "$file" "$(dirname "$file")/$newname"
else
  echo "Filename is already clean: $file"
fi
