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

# 6. Configurar Tmux
# Se seu tmux.conf tiver "source-file ~/.cache/wal/colors-tmux.conf"
tmux source-file ~/.config/tmux/tmux.conf

# Atualiza o Alacritty (opcional, geralmente ele faz hot-reload sozinho)
# O simples fato do arquivo .toml ser reescrito pelo wal já deve disparar a mudança.
# Se não mudar, você pode forçar 'tocando' no arquivo de config principal:
touch ~/.config/alacritty/alacritty.toml
# 7. Configurar Alacritty (se ainda usar)
# O Pywal geralmente atualiza o alacritty se configurado, nada a fazer aqui se o wal já roda.

# 8. Notificação
notify-send "Tema alterado" "Wallpaper e cores atualizados!"
