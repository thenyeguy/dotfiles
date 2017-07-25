function timestamp
    if test (count $argv) -gt 0
        date -d @$argv[1]
    else
        date +%s
    end
end
