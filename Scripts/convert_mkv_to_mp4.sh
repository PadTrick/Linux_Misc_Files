#!/bin/sh
mkdir -p transcoded
for i in *.mkv; do
    ffmpeg -i "$i" \
    -c:v libx264 -preset medium -crf 23 \
    -c:a aac -b:a 192k \
    -movflags +faststart \
    "transcoded/${i%.*}.mp4"
done
echo "ALL FILES ENCODED !!!"
