#!/bin/bash

# Function to check and install Homebrew
check_and_install_homebrew() {
    if ! command -v brew &> /dev/null; then
        dialog --infobox "Homebrew not found. Installing..." 5 40
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        if ! command -v brew &> /dev/null; then
            dialog --msgbox "Failed to install Homebrew. Exiting..." 7 40
            exit 1
        fi
    fi
}

# List of packages available for installation (name, description, initial state)
PACKAGES=(
  "ghostty" "Terminal" on
  "yazi" "file manager" off
  "gh" "GitHub CLI" off
  "ripgrep" "Search tool" off
)

# Function to display the selection menu
show_menu() {
    local options=()
    for ((i = 0; i < ${#PACKAGES[@]}; i += 3)); do
        options+=("$((i / 3 + 1))" "${PACKAGES[i]} (${PACKAGES[i + 1]})" "${PACKAGES[i + 2]}")
    done

    dialog --clear --separate-output --checklist \
        "Select the packages to install:" 15 50 8 \
        "${options[@]}" 2> "$TEMP_FILE"
}

# Call the function to check and install Homebrew
check_and_install_homebrew

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

# Install the selected packages
for choice in $SELECTED_PACKAGES; do
    index=$(( (choice - 1) * 3 ))
    PACKAGE="${PACKAGES[index]}"
    dialog --infobox "Installing $PACKAGE..." 5 40
    brew install "$PACKAGE"
    if [ $? -eq 0 ]; then
        dialog --msgbox "$PACKAGE installed successfully!" 7 40
    else
        dialog --msgbox "Failed to install $PACKAGE." 7 40
    fi
done
