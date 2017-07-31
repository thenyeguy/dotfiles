# Adapted from builtin __fish_hg_prompt

function hg_prompt -d "Prints mercurial VCS info for prompt"
    # Find an hg directory above $PWD
    # without calling `hg root` because that's too slow
    set -l root
    set -l dir $PWD
    while test $dir != "/"
        if test -f $dir'/.hg/dirstate'
            set root $dir"/.hg"
            break
        end
        # Go up one directory
        set -l dir (string replace -r '[^/]*/?$' '' $dir)
    end

    if test -z "$root"
        return 0
    end

    # Read branch and bookmark
    set -l branch (cat $root/branch ^/dev/null; or echo default)
    if set -l bookmark (cat $root/bookmarks.current ^/dev/null)
        set branch "$branch|$bookmark"
    end
    echo -n $branch
end
