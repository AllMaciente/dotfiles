installGhostty(){
    dialog --infobox "Installing ghostty terminal (unofficial Ubuntu/Debian package (.deb))" 3 40
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
}
installFishShell(){
    dialog --ingobox "Installing fish shell" 3 40
    sleep 2
    dialog --ingobox "Adding fish shell repository" 3 40
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update && sudo apt-get upgrade
    dialog --ingobox "Installing fish shell" 3 40
    sudo apt-get install fish
    dialog --yesno "set fish default" 7 50
    response=$?
    if [ $response -eq 0 ]; then
        sudo chsh -s /usr/local/bin/fish
    fi
}
install_package() {
    local package=$1
    dialog --infobox "Installing $package..." 5 40
    sudo apt install -y "$package"
    if [ $? -eq 0 ]; then
        dialog --infobox "$package installed successfully!" 7 40
    else
        dialog --msgbox "Failed to install $package." 7 40
    fi
}


}installZoxide(){
    dialog --infobox "Installing zoxide" 3 40
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}
insta
installStarship(){
    dialog --infobox "Installing starship" 3 40
    curl -sS https://starship.rs/install.sh | sh
}
cmd=(dialog --clear --separate-output --checklist "Select (with space) what script should do." 26 86 16)
options=(1 "ghostty terminal (unofficial Ubuntu/Debian package (.deb))" on
        2 "fish shell" on
        3 "i3 window manager" on
        4 "polybar" on
        5 "rofi" on
        6 "picom" on
        7 "feh" on
        8 "flameshot" on
        9 "zoxide" on
        10 "dunst" on
        11 "starship" on
      )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

for choice in $choices
do
    case $choice in
        1)  installGhostty;;
        2)  installFishShell;;
        3)  install_package "i3";;
        4)  install_package "polybar";;
        5)  install_package "rofi";;
        6)  install_package "picom";;
        7)  install_package "feh";;
        8)  install_package "flameshot";;
        9) installZoxide;;
        10) install_package "dunst";;
        11) installStarship;;
        esac
done 
