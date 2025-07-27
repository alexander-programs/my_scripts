#!/bin/bash

shopt -s nocaseglob nullglob

rename_tv_file() {
  local file="$1"

  [[ -f "$file" ]] || return

  local extension="${file##*.}"

  # Get filename without extension
  local base="${file%.*}"

  # Remove resolution patterns like .1080p., -720p-, _480_, etc. (case insensitive)
  base=$(echo "$base" | sed -E 's/([._-])([0-9]{3,4}p?)([._-]|$)/\1\3/Ig')

  # Replace dots, spaces, and dashes with underscores
  local cleaned="$base"
  cleaned=$(echo "$cleaned" | sed -E 's/[ .-]+/_/g')

  # Collapse multiple underscores into one
  cleaned=$(echo "$cleaned" | sed -E 's/_+/_/g')

  # Remove leading or trailing underscores if any
  cleaned=$(echo "$cleaned" | sed -E 's/^_+|_+$//g')

  # Convert to lowercase
  cleaned=$(echo "$cleaned" | tr '[:upper:]' '[:lower:]')

  # Match title + season/episode pattern (S01E07, s2e7, etc.)
  if [[ $cleaned =~ (.+)_s([0-9]{1,2})e([0-9]{1,2})(_|$) ]]; then
    local title="${BASH_REMATCH[1]}"
    local season=$(printf "%02d" "${BASH_REMATCH[2]}")
    local episode=$(printf "%02d" "${BASH_REMATCH[3]}")
    local newname="${title}_s${season}e${episode}.${extension}"

    # Rename only if needed
    if [[ "$file" != "$newname" ]]; then
      echo "Renaming: $file → $newname"
      mv -iv "$file" "$newname"
    else
      echo "Already clean: $file"
    fi
  else
    echo "Skipping (no episode pattern found): $file"
  fi
}

# If a filename is provided, process just that file
if [[ $# -gt 0 ]]; then
  rename_tv_file "$1"
else
  # Batch mode: process all supported video files
  video_exts=("*.mkv" "*.mp4" "*.avi" "*.mov" "*.flv" "*.wmv")
  for ext in "${video_exts[@]}"; do
    for file in $ext; do
      rename_tv_file "$file"
    done
  done
fi
