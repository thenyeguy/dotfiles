function __complete_needs_subcmd \
        -d 'Returns 0 if this completion still needs a subcommand'
    set cmd (commandline -opc)
    test (count $cmd) -eq 1
end
