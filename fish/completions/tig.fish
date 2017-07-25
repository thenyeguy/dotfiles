# Complete subcommands
complete -c tig -n '__complete_needs_subcmd' -a log \
    -d 'Start up in log view.'
complete -c tig -n '__complete_needs_subcmd' -a show \
    -d 'Open diff view.'
complete -c tig -n '__complete_needs_subcmd' -a blame \
    -d 'Show given file annotated by commits.'
complete -c tig -n '__complete_needs_subcmd' -a stash \
    -d 'Display the list of stashes.'
complete -c tig -n '__complete_needs_subcmd' -a status \
    -d 'Start up in status view.'

complete -c tig -a (git branch | xargs | sed 's/\* //') -d 'Branch'
