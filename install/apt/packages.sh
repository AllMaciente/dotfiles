#!/bin/bash
# filepath: /home/allan/dotfiles/install/apt/packages.sh

# Function to check and install a package
install_package() {
    local package=$1
    dialog --infobox "Installing $package..." 5 40
    sudo apt install -y "$package"
    if [ $? -eq 0 ]; then
        dialog --msgbox "$package installed successfully!" 7 40
    else
        dialog --msgbox "Failed to install $package." 7 40
    fi
}

# Function to install GitHub CLI
install_github_cli() {
    dialog --infobox "Installing GitHub CLI..." 5 40
    type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)
    sudo mkdir -p -m 755 /etc/apt/keyrings
    out=$(mktemp)
    wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg
    cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh -y
    if [ $? -eq 0 ]; then
        dialog --msgbox "GitHub CLI installed successfully!" 7 40
    else
        dialog --msgbox "Failed to install GitHub CLI." 7 40
    fi
}

install_TailScale(){
    dialog --infobox "Installing TailScale..." 5 40
    curl -fsSL https://tailscale.com/install.sh | sh
}
# List of options for the menu
cmd=(dialog --clear --separate-output --checklist "Select the packages to install:" 15 50 8)
options=(
    1 "curl (Data transfer tool)" off
    2 "git (Version control system)" off
    3 "bashtop (Interactive process monitor)" off
    4 "zoxide (Fast directory jumper)" off
    5 "eza (Modern replacement for ls)" off
    6 "gh (GitHub CLI)" off
    7 "ripgrep (Search tool)" off
    8 "tailScale (private VPN)" off
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

# Process the selected choices
for choice in $choices; do
    case $choice in
        1) install_package "curl";;
        2) install_package "git";;
        3) install_package "bashtop";;
        4) install_package "zoxide";;
        5) install_package "eza";;
        6) install_github_cli;;
        7) install_package "ripgrep";;
        8) install_TailScale;;
    esac
done