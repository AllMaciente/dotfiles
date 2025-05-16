#!/bin/bash
# Function to install a Flatpak package
install_flatpak_package() {
    local package=$1
    dialog --infobox "Installing $package..." 5 40
    flatpak install -y "$package"
    if [ $? -eq 0 ]; then
        dialog --msgbox "$package installed successfully!" 7 40
    else
        dialog --msgbox "Failed to install $package." 7 40
    fi
}

# List of options for the menu
cmd=(dialog --clear --separate-output --checklist "Select (with space) the Flatpak packages to install:" 20 60 10)
options=(
    1 "Spotify (Music Player)" off
    2 "Discord (Chat)" off
    3 "Gearlever (AppImage Manager)" off
    4 "Warehouse (Flatpak Manager)" off
    5 "LibreSprite (pixelArt)" off
    6 "LocalSend" off
    7 "PikaBackup" off
    8 "Trayscale (gui for tailScale)" off
    9 "IntelliJ IDEA Community" off
    10 "PolyMC (minecraft laucher)" off
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

# Process the selected choices
for choice in $choices; do
    case $choice in
        1) install_flatpak_package "com.spotify.Client";;
        2) install_flatpak_package "com.discordapp.Discord";;
        3) install_flatpak_package "it.mijorus.gearlever";;
        4) install_flatpak_package "io.github.flattool.Warehouse";;
        5) install_flatpak_package "com.github.libresprite.LibreSprite";;
        6) install_flatpak_package "org.localsend.localsend_app";;
        7) install_flatpak_package "org.gnome.World.PikaBackup";;
        8) install_flatpak_package "dev.deedles.Trayscale";;
        9) install_flatpak_package "com.jetbrains.IntelliJ-IDEA-Community";;
        10) install_flatpak_package "org.polymc.PolyMC";;
    esac
done
