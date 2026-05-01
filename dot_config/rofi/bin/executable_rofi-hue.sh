#!/usr/bin/env bash

# 1. Gera a lista de temas limpa
theme_list=$(huectl list | grep -E '^  [○●]' | sed 's/^[[:space:]]*[○●][[:space:]]*//')

selected=$(echo -e "󰑓 reload\n$theme_list" | rofi -dmenu -p "Selecionar Tema:")

# 3. Lógica de aplicação
if [ "$selected" = "󰑓 reload" ]; then
    huectl reload
elif [ -n "$selected" ]; then
    # Aplica o tema específico selecionado
    huectl apply "$selected"
fi
