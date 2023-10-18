#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | cut -f 2 -d '/' | cut -d '%' -f 1 | xargs
}

function send_notification {
  iconSound="audio-volume-high"
  iconMuted="audio-volume-muted"
  if is_mute ; then
    dunstify -i $iconMuted -r 2593 -u normal "Muted"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="─" 0 "$(((volume - 1) / 4))" | sed 's/[0-9]//g')
    space=$(seq --separator=" " 0 "$(((100 - volume) / 4))" | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i $iconSound -r 2593 -u normal "|$bar$space| $volume%"
  fi
}

case $1 in
  up)
    # up the volume (+ 5%)
    wpctl set-volume @DEFAULT_SINK@ 5%+ -l 1.0 > /dev/null
    send_notification
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -5% > /dev/null
    send_notification
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
    ;;
  mute)
esac
