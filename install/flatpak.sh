#!/bin/bash

# Function to check and install Flatpak
check_and_install_flatpak() {
    if ! command -v flatpak &> /dev/null; then
        dialog --infobox "Flatpak not found. Installing..." 5 40
        sudo apt update && sudo apt install -y flatpak
        
        if ! command -v flatpak &> /dev/null; then
            dialog --msgbox "Failed to install Flatpak. Exiting..." 7 40
            exit 1
        fi
    fi
}

# List of Flatpak packages available for installation (name, description, initial state)
PACKAGES=(
  "com.spotify.Client" "Spotify music streaming" off
  "com.discordapp.Discord" "Discord chat and voice" off
  "it.mijorus.gearlever" "AppImage manager" off
  "io.github.flattool.Warehouse" "Flatpak manager" off
  "com.github.libresprite.LibreSprite" "PixelArt" off
  "org.localsend.localsend_app" "LocalSend" off
  "org.gnome.World.PikaBackup" "Backup tool" off
  "dev.deedles.Trayscale" "Trayscale" off
)

# Function to display the selection menu
show_menu() {
    local options=()
    for ((i = 0; i < ${#PACKAGES[@]}; i += 3)); do
        options+=("$((i / 3 + 1))" "${PACKAGES[i]} (${PACKAGES[i + 1]})" "${PACKAGES[i + 2]}")
    done

    dialog --clear --separate-output --checklist \
        "Select the Flatpak packages to install:" 15 50 8 \
        "${options[@]}" 2> "$TEMP_FILE"
}

# Call the function to check and install Flatpak
check_and_install_flatpak

# Temporary file to store the selection
TEMP_FILE=$(mktemp)

# Display the menu
show_menu

# Read the selected packages
SELECTED_PACKAGES=$(cat "$TEMP_FILE")
rm -f "$TEMP_FILE"

# Check if anything was selected
if [ -z "$SELECTED_PACKAGES" ]; then
    dialog --msgbox "No packages selected. Exiting..." 7 40
    exit 0
fi

# Concatenate all selected packages into a single command
PACKAGES_TO_INSTALL=""
for choice in $SELECTED_PACKAGES; do
    index=$(( (choice - 1) * 3 ))
    PACKAGES_TO_INSTALL+="${PACKAGES[index]} "
done

# Install all selected Flatpak packages in one command
dialog --infobox "Installing selected packages..." 5 40
flatpak install -y $PACKAGES_TO_INSTALL
if [ $? -eq 0 ]; then
    dialog --msgbox "All selected packages installed successfully!" 7 40
else
    dialog --msgbox "Failed to install some packages." 7 40
fi