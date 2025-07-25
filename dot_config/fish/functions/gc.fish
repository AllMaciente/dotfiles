function gc
    if  test (count $argv) -gt 0
        git commit -m $argv
    else
        git commit
    end
end
