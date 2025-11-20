#!/bin/bash

# Onde estão seus wallpapers
WALLPAPER_DIR="$HOME/Wallpapers"

# Verifica se o Rofi já está rodando
if pgrep -x "rofi" > /dev/null; then
    pkill rofi
    exit 0
fi

# Lógica mágica do Rofi com ícones
# Ele lista os arquivos e manda o caminho da imagem como ícone para o Rofi ler
selecionado=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r file; do
    filename=$(basename "$file")
    # A sintaxe \0icon\x1f diz ao Rofi para usar o arquivo como ícone da entrada
    echo -en "$filename\0icon\x1f$file\n" 
done | rofi -dmenu -i -show-icons -p "Wallpaper" -theme "~/.config/rofi/wallpaper-select.rasi")

# Se o usuário selecionou algo, chama o script aplicador
if [ -n "$selecionado" ]; then
    # Reconstrói o caminho completo (o rofi retorna só o nome do arquivo se usarmos o basename acima)
    # Mas como passamos o filename no echo, precisamos buscar o caminho de novo ou simplificar.
    # Vamos simplificar: O 'selecionado' será o nome do arquivo.
    
    FULL_PATH=$(find "$WALLPAPER_DIR" -name "$selecionado" | head -n 1)
    ~/.local/bin/apply_theme.sh "$FULL_PATH"
fi
