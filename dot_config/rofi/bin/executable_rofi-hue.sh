#!/usr/bin/env bash

# 1. Gera a lista de temas limpa
theme_list=$(huectl list | grep -E '^  [○●]' | sed 's/^[[:space:]]*[○●][[:space:]]*//')

# 2. Adiciona a opção "Random" no topo e abre o Rofi
# O pipe "echo -e" serve para colocar o Random antes da lista original
selected=$(echo -e "󰒡 Random Theme\n$theme_list" | rofi -dmenu -p "Selecionar Tema:")

# 3. Lógica de aplicação
if [ "$selected" = "󰒡 Random Theme" ]; then
    # Sorteia um tema da lista original
    random_theme=$(echo "$theme_list" | shuf -n 1)
    huectl apply "$random_theme"
elif [ -n "$selected" ]; then
    # Aplica o tema específico selecionado
    huectl apply "$selected"
fi