if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish --cmd cd | source

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
