#!/bin/bash

dialog --infobox "Starting system update..." 3 40
sleep 2

dialog --infobox "Updating package list..." 3 40
sudo apt update > /dev/null 2>&1

dialog --infobox "Upgrading installed packages..." 3 40
sudo apt upgrade -y > /dev/null 2>&1

dialog --msgbox "System update completed successfully!" 5 50
clear