#!/bin/bash
notify-send 'Hello world!' 'This is an example notification.' --icon=dialog-information
album_art=$(playerctl metadata mpris:artUrl)
if [[ -z $album_art ]]
then
   exit
fi
curl -s  "${album_art}" --output "/tmp/cover.jpeg"
echo "/tmp/cover.jpeg"

