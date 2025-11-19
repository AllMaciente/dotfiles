# My Dotfiles

This repository contains my personal dotfiles, managed by [chezmoi](https://chezmoi.io). It includes configurations for my shell, editor, terminal, and various other tools to create a consistent and productive development environment.

## Installation

These dotfiles can be installed on a new system with a single command using `chezmoi`.

1.  **Install chezmoi and apply the dotfiles:**

    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply allmaciente
    ```

2.  **Follow any post-installation instructions** that may appear for specific tools (e.g., installing `nvim` plugins).

## Repository Contents

This repository is structured to be managed by `chezmoi`. The main configuration files are located in the `dot_config/` directory, which corresponds to `~/.config/`.

| Directory         | Description                                                 |
| ----------------- | ----------------------------------------------------------- |
| `alacritty/`      | Alacritty terminal emulator configuration.                  |
| `dunst/`          | Dunst notification daemon configuration.                    |
| `fastfetch/`      | Fastfetch system information tool configuration.            |
| `fish/`           | Fish shell configuration, functions, and plugins.           |
| `ghostty/`        | Ghostty terminal emulator configuration.                    |
| `hypr/`           | Hyprland Wayland compositor configuration.                  |
| `kanata/`         | Kanata keyboard remapper configuration.                     |
| `nvim/`           | Neovim text editor configuration with Lua and plugins.      |
| `rofi/`           | Rofi application launcher and window switcher configuration.|
| `tmux/`           | Tmux terminal multiplexer configuration.                    |
| `waybar/`         | Waybar status bar for Wayland compositors configuration.    |


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
