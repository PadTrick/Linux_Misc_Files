#!/bin/bash
mkdir mp3
for f in *.m4a;
  do ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 mp3/"${f%.m4a}.mp3";
done
echo "Converting m4a into mp3 finished !!!"
