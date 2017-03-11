function __complete_in_subcmd -a subcmd \
        -d 'Returns 0 if this command is currently in the specified subcommand'
    set cmd (commandline -opc)
    if test (count $cmd) -gt 1
        if test $subcmd = $cmd[2]
            return 0
        end
    end
    return 1
end
