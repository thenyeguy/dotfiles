function add_to_path
    for arg in $argv;
        contains $arg $PATH; or set PATH $arg $PATH
    end
end
