function fzf-git-commit
    if not silent git rev-parse --git-dir
        return 1
    end

    set revision (git log -n 50 --color=always \
                  --pretty=format:"%Cgreen%h%Creset - %s%C(yellow)%d%Creset" \
                  | fzf-tmux --ansi --no-sort -p \
                  | cut -d' ' -f1)
    if test -n "$revision"
        commandline -it -- $revision
        commandline -f repaint
    end
end
