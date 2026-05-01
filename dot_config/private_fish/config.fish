
if not type -q brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end

if status is-interactive
    # Prompt e Ferramentas (Usar --on-variable para performance se quiser, mas assim é o padrão)
    starship init fish | source
    zoxide init fish | source
    tv init fish | source

    # Aliases
    alias ruv="uv run"
    alias clip="wl-copy"  
    
    alias kanata-on='systemctl --user start kanata.service'
    alias kanata-off='systemctl --user stop kanata.service'
    
    alias vpg='export $(grep -v "^#" .env | xargs) && vd $DATABASE_URL'
    alias vmg='export $(grep -v "^#" .env | xargs) && vd $MONGO_URI'
    
    #alias ctheme='wal --theme "$(basename -s .json -a ~/.config/wal/colorschemes/dark/*.json | fzf)"'
    #alias ctheme='wal --theme "$(basename -s .json -a ~/.config/wal/colorschemes/**/*.json | fzf)"'

    # Auto-instalação do Fisher
    if not functions -q fisher
        echo "Instalando fisher..."
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    end

    # Limpeza e Tmux
    clear
end

# opencode
fish_add_path /home/all/.opencode/bin
set -Ux XDG_CACHE_HOME $HOME/.cache