if status is-interactive
    # zoxide (substitui o cd)
    zoxide init fish | source
    
    # Linuxbrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    alias ruv="uv run"
    alias clip="wl-copy"
    alias dot="chezmoi"
    alias kanata-on='systemctl --user start kanata.service'
    alias kanata-off='systemctl --user stop kanata.service'
    # fisher plugin manager
    if not functions -q fisher
        echo "Instalando fisher..."
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    end
end
# starship (prompt)
starship init fish | source

# Inicia o gnome-keyring se necessário
if not pgrep -x gnome-keyring-daemon > /dev/null
    eval (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
end

# Exporta o SSH_AUTH_SOCK se estiver disponível
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket 2>/dev/null)

clear

fish_add_path /home/all/.spicetify
