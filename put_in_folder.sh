#!/bin/bash

# Check if a file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 filename"
  exit 1
fi

# Get the full file path
FILE="$1"

# Check if the file exists
if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

# Extract base name (without path)
BASENAME="$(basename "$FILE")"

# Extract name without extension
NAME="${BASENAME%.*}"

# Create directory
mkdir -p "$NAME"

# Move file into the directory
mv "$FILE" "$NAME/"

echo "✅ Moved '$FILE' into '$NAME/'"

