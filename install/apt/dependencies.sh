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

installI3wm(){
    dialog --infobox "Installing i3 window manager" 3 40
    sudo apt install -y i3
}
InstallPolybar(){
    dialog --infobox "Installing polybar" 3 40
    sudo apt install -y polybar
}

installUlauncher(){
    dialog --infobox "Installing ulauncher" 3 40
    sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install ulauncher
}
installPicom(){
    dialog --infobox "Installing picom" 3 40
    sudo apt install -y picom
}
installFeh(){
    dialog --infobox "Installing feh" 3 40
    sudo apt install -y feh
}

cmd=(dialog --clear --separate-output --checklist "Select (with space) what script should do." 26 86 16)
options=(1 "ghostty terminal (unofficial Ubuntu/Debian package (.deb))" on
        2 "ghostty terminal (Homebrew)" off
        3 "fish shell" on
        4 "i3 window manager" on
        5 "polybar" on
        6 "ulauncher" on
        7 "picom" on
        8 "feh" on
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

for choice in $choices
do
    case $choice in
        1)  installGhostty;;
        2)  bash install/homebrew.sh;;
        3)  installFishShell;;
        4)  installI3wm;;
        5)  InstallPolybar;;
        6)  installUlauncher;;
        7)  installPicom;;
        8)  installFeh;;
        esac
done 