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

# Extract extension
extension="${file##*.}"

# Step 1: Replace spaces and periods with underscores
cleaned="${file//[. ]/_}"

# Step 2: Convert to lowercase
cleaned=$(echo "$cleaned" | tr '[:upper:]' '[:lower:]')

# Step 3: Extract title and 4-digit year, skip resolutions
if [[ $cleaned =~ ^(.+?)_([12][0-9]{3})[^0-9] ]]; then
  title="${BASH_REMATCH[1]}"
  year="${BASH_REMATCH[2]}"
  newname="${title}_${year}.${extension}"

  # Rename if different
  if [[ "$file" != "$newname" ]]; then
    echo "Renaming: $file → $newname"
    mv -i "$file" "$newname"
  else
    echo "Filename is already clean: $file"
  fi
else
  echo "Could not extract valid title/year from: $file"
fi

