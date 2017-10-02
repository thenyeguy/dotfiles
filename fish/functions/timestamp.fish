function timestamp
    if test (count $argv) -gt 0
        for ts in $argv
            date -d @$ts
        end
    else
        date +%s
    end
end
