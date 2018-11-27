function timestamp
    if test (count $argv) -gt 0
        for ts in $argv
            set ts (echo $ts | cut -c 1-10)
            date -d @$ts
        end
    else
        date +%s
    end
end
