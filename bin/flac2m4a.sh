#!/bin/bash
#Usage: first argument is quality, 1-5, default is 4
doConv () {
  local file=$2
  ffmpeg -i "$file" -c:a libfdk_aac -vbr $1 "${file/.flac/.m4a}" &> /dev/null && rm -f "$file"
}
export -f doConv
find . -type f -name "*.flac" | parallel --eta doConv ${1:-4}
