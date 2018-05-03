# Adapted from builtin __fish_hg_prompt

function hg_prompt -d "Prints mercurial VCS info for prompt"
    set -l root (hg_root)
    if test -z "$root"
        return
    end

    # Read branch and bookmark
    set -l branch (cat $root/branch ^/dev/null; or echo default)
    if set -l bookmark (cat $root/bookmarks.current ^/dev/null)
        set branch "$branch|$bookmark"
    end
    echo -n $branch
end
