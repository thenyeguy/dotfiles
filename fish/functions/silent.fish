function silent -d 'Runs the provided command with all output silenced.'
    eval $argv >/dev/null ^/dev/null
end
