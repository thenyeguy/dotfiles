function label --description "Draws a decorated mode prompt"
    set color $argv[1]
    set label $argv[2]

    set_color --bold --background $color black
    echo -n " $label "
    set_color --background normal $color
    echo "$segment_seperator"
end

function fish_mode_prompt --description "Displays the current vi mode"
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        label yellow 'N'
      case insert
        echo '     '
      case replace-one
        label red 'R'
      case visual
        label blue V
    end
  end
end
