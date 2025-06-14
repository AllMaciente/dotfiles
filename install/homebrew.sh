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

# Function to install spring-cli with tap
install_spring_cli() {
    brew tap spring-cli-projects/spring-cli
    brew install spring-cli
}

# Function to install a generic package
install_package() {
    local package=$1
    dialog --infobox "Installing $package..." 5 40
    brew install "$package"
    if [ $? -eq 0 ]; then
        dialog --msgbox "$package installed successfully!" 7 40
    else
        dialog --msgbox "Failed to install $package." 7 40
    fi
}
# Call the function to check and install Homebrew
check_and_install_homebrew

# List of options for the menu
cmd=(dialog --clear --separate-output --checklist "Select the packages to install:" 26 86 16)
options=(
    1 "Install zoxide (Z Shell Plugin)" off
    2 "Install yazi (File Manager)" off
    3 "Install gh (GitHub CLI)" off
    4 "Install ripgrep (Search Tool)" off
    5 "Install spring-cli (Spring Boot Tools)" off
    6 "starship (Prompt)" off
    7 "spicetify-cli (Spotify Customization)" off
    8 "tldr Simplified and community-driven man pages." off
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

# Process the selected choices
for choice in $choices; do
    case $choice in
        1) install_package "zoxide";;
        2) install_package "yazi";;
        3) install_package "gh";;
        4) install_package "ripgrep";;
        5) install_spring_cli;;
        6) install_package "starship";;
        7) install_package "spicetify-cli";;
        8) install_package "tldr";;
    esac
done
