#!/bin/bash

set -e

# Detectar o gerenciador de pacotes
if command -v apt &>/dev/null; then
    PKG="apt"
# elif command -v dnf &>/dev/null; then
#     PKG="dnf"
# elif command -v pacman &>/dev/null; then
#     PKG="pacman"
else
    echo "Sistema não suportado."
    exit 1
fi

create_default_directories(){
    echo -e "${green}[*] Copying configs to $config_directory.${no_color}"
    mkdir -p "$HOME"/.config
    sudo mkdir -p  /usr/local/bin
    sudo mkdir -p  /usr/share/themes
    mkdir -p "$HOME"/Pictures/wallpapers
}


create_backup() {
  local src_dir="$PWD/config"
  local dest_dir="$HOME/.config"
  local backup_dir="$dest_dir/bkup/$(date +%Y%m%d_%H%M%S)"

  mkdir -p "$backup_dir"

  dialog --infobox "Criando backup das configs existentes..." 3 45
  sleep 1

  for item in "$src_dir"/*; do
    local base=$(basename "$item")
    local target="$dest_dir/$base"

    if [ -e "$target" ]; then
      mkdir -p "$(dirname "$backup_dir/$base")"
      mv "$target" "$backup_dir/$base"
      dialog --infobox "Backup de $base criado." 3 45
      sleep 0.5
    fi
  done

  dialog --msgbox "Backup completo salvo em:\n$backup_dir" 6 50
}
install_wallpapers() {
  local src_dir="$PWD/wallpapers"
  local dest_dir="$HOME/Pictures/wallpapers"

  if [ ! -d "$src_dir" ]; then
    dialog --msgbox "Pasta 'wallpapers' não encontrada no repositório." 5 50
    return
  fi

  mkdir -p "$dest_dir"

  dialog --infobox "Copiando wallpapers para $dest_dir..." 3 45
  sleep 1

  for wallpaper in "$src_dir"/*; do
    if [ -f "$wallpaper" ]; then
      cp -u "$wallpaper" "$dest_dir/"
      local name=$(basename "$wallpaper")
      dialog --infobox "Wallpaper '$name' copiado." 3 45
      sleep 0.3
    fi
  done

  dialog --msgbox "Wallpapers copiados com sucesso para $dest_dir!" 5 50
}


copy_configs(){
    dialog --infobox "Configs copied to $HOME/.config" 3 40
    cp -r config/* "$HOME"/.config
}

install_fonts() {
  local src_dir="$PWD/fonts"
  local dest_dir="$HOME/.local/share/fonts"

  if [ ! -d "$src_dir" ]; then
    dialog --msgbox "Pasta 'fonts' não encontrada no repositório." 5 50
    return
  fi

  mkdir -p "$dest_dir"

  dialog --infobox "Copiando fontes para o sistema..." 3 45
  sleep 1

  for font in "$src_dir"/*; do
    if [ -f "$font" ]; then
      cp -u "$font" "$dest_dir/"
      local name=$(basename "$font")
      dialog --infobox "Fonte '$name' copiada." 3 45
      sleep 0.3
    fi
  done

  fc-cache -f > /dev/null 2>&1
  dialog --msgbox "Fontes copiadas com sucesso e cache atualizado!" 5 50
}



cmd=(dialog --clear --separate-output --checklist "Select (with space) what script should do.\\nChecked options are required for proper installation, do not uncheck them if you do not know what you are doing." 26 86 16)
options=(1 "System update" on
        2 "Install dependencies" on
        3 "Create default directories" on
        4 "Create backup of existing configs (to prevent overwritting)" on
        5 "copy configs to $HOME/.config" on
        6 "install fonts" on
        7 "install Wallpapers" on
        8 "Install other packages" off
        9 "Install other Homebrew packages" off
        10 "Install other flatpak packages" off
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

for choice in $choices
do
    case $choice in
        1) bash install/${PKG}/updateSystem.sh;;
        2) bash install/${PKG}/dependencies.sh;;
        3) create_default_directories;;
        4) create_backup;;
        5) copy_configs;;
        6) install_fonts;;
        7) install_wallpapers;;
        8) bash install/${PKG}/packages.sh;;
        9) bash install/homebrew.sh;;
        10) bash install/flatpak.sh;;
    esac
done