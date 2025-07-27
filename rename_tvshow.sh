#!/bin/bash

shopt -s nocaseglob nullglob

rename_tv_file() {
  local file="$1"

  [[ -f "$file" ]] || return

  local extension="${file##*.}"
  local base="${file%.*}"

  # Remove resolution patterns like .1080p., -720p-, _480_, etc. (case insensitive)
  base=$(echo "$base" | sed -E 's/([._-])([0-9]{3,4}p?)([._-]|$)/\1\3/Ig')

  # Replace dots, spaces, and dashes with underscores
  local cleaned="$base"
  cleaned=$(echo "$cleaned" | sed -E 's/[ .-]+/_/g')
  cleaned=$(echo "$cleaned" | sed -E 's/_+/_/g')             # Collapse multiple underscores
  cleaned=$(echo "$cleaned" | sed -E 's/^_+|_+$//g')         # Trim leading/trailing underscores
  cleaned=$(echo "$cleaned" | tr '[:upper:]' '[:lower:]')    # Convert to lowercase

  # Match title + season/episode pattern (S01E07, s2e7, etc.)
  if [[ $cleaned =~ (.+)_s([0-9]{1,2})e([0-9]{1,2})(_|$) ]]; then
    local titl
