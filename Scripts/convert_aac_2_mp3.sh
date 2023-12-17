#!/bin/bash
mkdir mp3
for f in *.aac;
  do ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 mp3/"${f%.aac}.mp3";
done
echo "Converting aac into mp3 finished !!!"
