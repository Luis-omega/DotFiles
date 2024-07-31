#!/bin/bash
notify-send 'Hello world!' 'This is an example notification.' --icon=dialog-information
album_art=$(playerctl metadata mpris:artUrl)
if [[ -z $album_art ]] 
then
   # spotify is dead, we should die too.
   exit
fi
curl -s  "${album_art}" --output "/tmp/cover.jpeg"
echo "/tmp/cover.jpeg"

