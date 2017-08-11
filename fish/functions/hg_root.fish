function hg_root -d "Finds the root of the current mercurial repository"
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
        return 1
    end
    echo -n "$root"
end
