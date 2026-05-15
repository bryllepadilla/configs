#!/bin/bash

#mkdir -p coveri
#logfile="log.txt"
#> "$logfile"  
#
#for file in *.mp3; do
#  [ -f "$file" ] || continue
#
#  echo "Processing $file" >> "$logfile"
#  eyeD3 --write-images=coveri "$file" 2>> "$logfile"
#  base_name=$(basename "$file" .mp3)
#  extracted_image=$(find coveri -type f -name "${base_name}-*.jpg" -print -quit)
#  
#  if [ -n "$extracted_image" ]; then
#    mv "$extracted_image" "coveri/${base_name}.jpg" 2>> "$logfile"
#    echo "Renamed image to coveri/${base_name}.jpg" >> "$logfile"
#  else
#    echo "No image extracted for $file" >> "$logfile"
#  fi
#done



#logfile="log.txt"
#for file in *.mp3; do
#	#[-f "$file" ] || continue
#
#	eyeD3 --write-images=coveri "$file" 2>> "$logfile"
#	base_name=$(basename "$file" .mp3)
#	extracted_image=$(find coveri -type f -name "${base_name}-*.jpg" -print -quit)
#
#done
