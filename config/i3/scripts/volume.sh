#!/bin/bash

# Aumenta/diminui/muta volume e mostra notificação

get_volume() {
  amixer get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]%'
}

case $1 in
  up)
    amixer -q sset Master 5%+ unmute
    ;;
  down)
    amixer -q sset Master 5%- unmute
    ;;
  mute)
    amixer -q sset Master toggle
    ;;
esac

volume=$(get_volume)
mute=$(amixer get Master | grep '\[off\]')

if [ "$mute" ]; then
  notify-send -t 1000 "🔇 Volume: Mutado"
else
  notify-send -t 1000 "🔊 Volume: $volume%"
fi

