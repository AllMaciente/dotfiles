if status is-interactive
    # zoxide (substitui o cd)
    zoxide init fish --cmd cd | source
    
    # Linuxbrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    # fisher plugin manager
    if not functions -q fisher
        echo "Instalando fisher..."
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    end
end
# starship (prompt)
starship init fish | source

clear