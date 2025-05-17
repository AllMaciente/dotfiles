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

cmd=(dialog --clear --separate-output --checklist "Select (with space) what script should do." 26 86 16)
options=(1 "ghostty terminal (unofficial Ubuntu/Debian package (.deb))" on
        2 "ghostty terminal (Homebrew)" off
        3 "fish shell" on
        4 "i3 window manager" on
        5 "polybar" on
        6 "rofi" on
        7 "picom" on
        8 "feh" on
        9 "flameshot" on
        10 "zoxide" on
        11 "dunst" on
        12 "starship" on
      )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

for choice in $choices
do
    case $choice in
        1)  installGhostty;;
        2)  bash install/homebrew.sh;;
        3)  installFishShell;;
        4)  install_package "i3";;
        5)  install_package "polybar";;
        6)  install_package "rofi";;
        7)  install_package "picom";;
        8)  install_package "feh";;
        9)  install_package "flameshot";;
        10) installZoxide;;
        11) install_package "dunst";;
        12) install_package "starship";;
        esac
done 
