function timestamp
    if test (count $argv) -gt 0
        for ts in $argv
            set ts (echo $ts | cut -c 1-10)
            if test (uname) = "Darwin"
                date -r $ts
            else
                date -d @$ts
            end
        end
    else
        date +%s
    end
end
