#!/bin/bash
# filepath: /home/allan/dotfiles/install/apt/packages.sh

# List of packages available for installation
PACKAGES=(
  1 "curl (Data transfer tool)" off
  2 "git (Version control system)" off
  3 "bashtop (Interactive process monitor)" off
  4 "zoxide (Fast directory jumper)" off
  5 "eza (Modern replacement for ls)" off
  6 "gh (GitHub CLI)" off
  7 "ripgrep (Search tool)" off
)

# Temporary file to store the selection
TEMP_FILE=$(mktemp)

# Function to display the selection menu
show_menu() {
  dialog --clear --separate-output --checklist \
    "Select the packages to install:" 15 50 8 \
    "${PACKAGES[@]}" 2> "$TEMP_FILE"
}

# Display the menu
show_menu

# Read the selected packages
SELECTED_PACKAGES=$(cat "$TEMP_FILE")
rm -f "$TEMP_FILE"

# Check if anything was selected
if [ -z "$SELECTED_PACKAGES" ]; then
  echo "No packages selected. Exiting..."
  exit 0
fi

# Map selected numbers to package names
PACKAGE_MAP=("curl" "git" "bashtop" "zoxide" "eza" "gh" "ripgrep")
INSTALL_PACKAGES=""
for choice in $SELECTED_PACKAGES; do
  if [ "${PACKAGE_MAP[$((choice - 1))]}" == "gh" ]; then
    # Special case for GitHub CLI installation
    echo "Installing GitHub CLI..."
    type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)
    sudo mkdir -p -m 755 /etc/apt/keyrings
    out=$(mktemp)
    wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg
    cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh -y
  else
    INSTALL_PACKAGES+="${PACKAGE_MAP[$((choice - 1))]} "
  fi
done

# Install the selected packages (excluding GitHub CLI)
if [ -n "$INSTALL_PACKAGES" ]; then
  echo "Installing packages: $INSTALL_PACKAGES"
  sudo apt update
  echo "$INSTALL_PACKAGES" | xargs sudo apt install -y
fi
