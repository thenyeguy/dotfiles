function fish_mode_prompt --description "Displays the current vi mode"
    set segment_seperator 

    function label -S -a color label
        set_color --bold --background $color black
        echo -n " $label "
        set_color --background normal $color
        echo "$segment_seperator"
    end

    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                label yellow 'N'
            case insert
                echo '         '
            case replace-one
                label red 'R'
            case visual
                label blue V
        end
    end
end
