#!/bin/sh

# Arguments
FILE_RAW=$1
CUT_FROM=${2:-10.0} # Default is 10.0
CUT_TO=${3:-10.0} # Default is 10.0

# Prepare variables
BASE_PATH=$(dirname $(readlink -f $FILE_RAW))
FILENAME_EXT="$(basename "${FILE_RAW}")"
FILENAME_ONLY="${FILENAME_EXT%.*}"
EXT_ONLY="${FILENAME_EXT#*.}" # Or hardcode it like "mp4"
FILENAME_ONLY_PATH="${BASE_PATH}/${FILENAME_ONLY}"

# Get next_video_name
last_video=$(ls -t1 ${FILENAME_ONLY}*.mp4 | head -n 1)
last_video_name="${last_video%.*}"
next_video_name=$(printf "%s-%02d\n" ${last_video_name%-*} $((${last_video_name##*-}+1)))

# Cutting
ffmpeg -i "${FILENAME_ONLY}.${EXT_ONLY}" -map 0 -c copy -ss "$CUT_FROM" -t "$CUT_TO" "${next_video_name}.${EXT_ONLY}"