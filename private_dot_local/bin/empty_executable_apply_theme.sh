#!/bin/bash
WALLPAPER="$1"

if [ -z "$WALLPAPER" ]; then
    echo "Uso: ./script.sh /caminho/para/wallpaper.jpg"
    exit 1
fi

# 1. Aplicar Wallpaper (SWWW)
swww img "$WALLPAPER" --transition-type any --transition-fps 60 --transition-duration 2

# 2. Gerar cores com Pywal (-n pula a aplicação no Xorg, já que usamos Wayland)
wal -i "$WALLPAPER" -n

# 3. Importar as novas cores para o script usar abaixo
. "${HOME}/.cache/wal/colors.sh"

# 4. Recarregar Waybar
pkill waybar && waybar &

# 5. Recarregar Dunst (Injetando cores e bordas arredondadas)
pkill dunst
dunst \
    -lb "$color0" -lf "$color7" -lfr "$color2" \
    -nb "$color0" -nf "$color7" -nfr "$color2" \
    -cb "$color1" -cf "$color7" -cfr "$color1" \
    -cr 12 -frame_width 2 &

# 6. Atualizar outros apps
tmux source-file ~/.config/tmux/tmux.conf
touch ~/.config/alacritty/alacritty.toml
pkill -USR1 nvim

# 7. Notificação
notify-send "Tema alterado" "Wallpaper e cores atualizados!"