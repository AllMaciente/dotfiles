#!/bin/bash

KANATA_DIR="$HOME/.config/kanata"

configs=$(find "$KANATA_DIR" -maxdepth 1 -name "*.kbd" -printf "%f\n" \
    | sed 's/\.kbd$//' \
    | sort)

selected=$(printf "Desativar\n%s\n" "$configs" | rofi -dmenu -i -p "Kanata")

[ -z "$selected" ] && exit 0

# Para TODOS os kanatas ativos
systemctl --user list-units --type=service --state=running \
    | grep 'kanata@.*\.service' \
    | awk '{print $1}' \
    | xargs -r systemctl --user stop

# Desativar
if [ "$selected" = "Desativar" ]; then
    notify-send "Kanata" "Desativado"
    exit 0
fi

# Inicia novo
systemctl --user start "kanata@$selected"

notify-send "Kanata" "Layout ativado: $selected"
