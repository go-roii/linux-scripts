#!/bin/bash
# converts mp4, mkv, and avi to mp3 using japanese audio

for i in *.{mp4,mkv,avi}; do
  ffmpeg -n -i "$i" -map 0:a:m:language:jpn? "${i%.*}.mp3"
done

echo -n 'Press enter to continue...'
read
