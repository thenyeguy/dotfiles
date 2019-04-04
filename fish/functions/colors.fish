function colors
    function show_color -a color
        echo -n (set_color $color)"$color "
        echo -n (set_color --bold $color)"$color "
        echo -n (set_color --dim $color)"$color "
        echo (set_color normal)
    end

    begin
        echo -n "normal "
        echo -n (set_color --bold)"bold "
        echo -n (set_color --dim)"dim"
        echo (set_color normal)

        for color in (set_color --print-colors)
            test $color != normal; and show_color $color
        end
    end | column -t
end
