# spit out current time stamp, or decode one if passed in
function timestamp
    set datecmd date
    if [ (uname) = "Darwin" ]
        set datecmd gdate
    end

    if test (count $argv) -gt 0
        for ts in $argv
            set ts (echo $ts | cut -c 1-10)
            $datecmd -d @$ts # decode timestamp
        end
    else
        # print timestamp
        $datecmd +%s
    end
end
