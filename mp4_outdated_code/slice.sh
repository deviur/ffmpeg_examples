#!/bin/bash

# Arguments
FILE_RAW=$1
CUT_DURATION=${2:-10.0} # Default is 10.0

# Prepare variables
BASE_PATH=$(dirname $(readlink -f $FILE_RAW))
FILENAME_EXT="$(basename "${FILE_RAW}")"
FILENAME_ONLY="${FILENAME_EXT%.*}"
EXT_ONLY="${FILENAME_EXT#*.}" # Or hardcode it like "mp4"
FILENAME_ONLY_PATH="${BASE_PATH}/${FILENAME_ONLY}"

# echo $CUT_DURATION
# Slicing
ffmpeg -i "${FILENAME_ONLY}.${EXT_ONLY}" -map 0 -c copy -t "$CUT_DURATION" "${FILENAME_ONLY}a.${EXT_ONLY}"
ffmpeg -i "${FILENAME_ONLY}.${EXT_ONLY}" -map 0 -c copy -ss "$CUT_DURATION" "${FILENAME_ONLY}b.${EXT_ONLY}"
