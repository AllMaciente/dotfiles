function lrg
    if test (count $argv) -eq 1
        eza --oneline | rg $argv[1]
    else
        set -l last_arg $argv[-1]
        set -e argv[-1]
        eza --oneline $argv | rg $last_arg
    end
end
