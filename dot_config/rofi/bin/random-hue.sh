#!/usr/bin/env bash

# 1. Pega a lista, limpa os ícones e joga em um array
themes=($(huectl list | grep -E '^  [○●]' | sed 's/^[[:space:]]*[○●][[:space:]]*//'))

# 2. Seleciona um tema aleatório do array
random_theme=${themes[$RANDOM % ${#themes[@]}]}

# 3. Aplica o tema sorteado
if [ -n "$random_theme" ]; then
    huectl apply "$random_theme"
    
    # Opcional: Notificação visual (se tiver o libnotify instalado)
    notify-send "Tema alterado" "Novo tema: $random_theme" -i preferences-desktop-theme
fi