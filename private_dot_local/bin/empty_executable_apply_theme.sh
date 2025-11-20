#!/bin/bash
WALLPAPER="$1"

# 1. Aplicar Wallpaper (SWWW com transição)
swww img "$WALLPAPER" --transition-type any --transition-fps 60 --transition-duration 2

# 2. Gerar cores com Pywal
wal -i "$WALLPAPER" -n

# 3. Recarregar Waybar
# O Waybar deve estar importando ~/.cache/wal/colors-waybar.css
pkill waybar && waybar &

# 4. Recarregar Dunst
# O Dunst precisa de um script extra ou configuração para ler pywal, 
# mas geralmente reiniciar ajuda se estiver linkado:
pkill dunst && dunst &

# 5. Configurar Ghostty
# O Ghostty lê as sequências de escape do terminal. 
# Vamos forçar a atualização enviando a sequência para todos os terminais abertos.
# (O Pywal já faz isso parcialmente, mas podemos garantir)
cat ~/.cache/wal/sequences > /dev/pts/[0-9]* 2>/dev/null

# 6. Configurar Tmux
# Se seu tmux.conf tiver "source-file ~/.cache/wal/colors-tmux.conf"
tmux source-file ~/.config/tmux/tmux.conf

# 7. Configurar Alacritty (se ainda usar)
# O Pywal geralmente atualiza o alacritty se configurado, nada a fazer aqui se o wal já roda.

# 8. Notificação
notify-send "Tema alterado" "Wallpaper e cores atualizados!"
