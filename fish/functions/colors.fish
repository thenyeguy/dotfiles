function colors
    function show_color -a color
        set_color normal
        set_color $color; echo -n "$color "
        set_color --bold; echo -n "$color "
        set_color --dim;  echo -n "$color "
        set_color normal; set_color --reverse $color; echo -n "$color "
        set_color normal; echo ""
    end

    begin
        set_color normal;    echo -n "normal "
        set_color --bold;    echo -n "bold "
        set_color --dim;     echo -n "dim "
        set_color --reverse; echo -n "reverse "
        set_color normal;    echo ""

        for color in (set_color --print-colors)
            test $color != normal; and show_color $color
        end
    end | column -t
end
