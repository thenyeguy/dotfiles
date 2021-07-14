declare-option -hidden str modeline_buffer_status
declare-option -hidden str modeline_buffer_name
declare-option -hidden str modeline_window_mode
declare-option -hidden str modeline_selections

define-command -hidden build-modeline %{
    set-option window modelinefmt %sh{
        mode_fg="rgb:ffaf00+b"
        file_fg="rgb:282828"
        file_bg="rgb:ebdbb2"
        info_fg="rgb:eeeeee"
        info_bg="rgb:875f5f"

        current_bg="default"
        function new_segment () {
            printf " {%s,%s}{%s,%s} " "$2" "$current_bg" "$1" "$2"
            current_bg=$2
        }

        printf "{%s}%s" "$mode_fg" "%opt{modeline_window_mode}"

        new_segment $file_fg $file_bg
        printf "%s" "%opt{modeline_buffer_status}"
        printf "%s" "%opt{modeline_buffer_name}"
        printf "%s" "{{context_info}}"

        new_segment $info_fg $info_bg
        printf "%s" "%opt{modeline_selections}"
        printf " %s:%s" "%val{cursor_line}" "%val{cursor_char_column}"
        printf " "
    }
}

define-command -hidden build-modeline-unfocused %{
    set-option window modelinefmt %sh{
        printf "{%s}  %s " "rgb:585858" "%opt{modeline_buffer_name}"
    }
}

hook global WinCreate .* %{
    hook window WinResize .* %{
        # Compute a shortened buffer name:
        set-option window modeline_buffer_name %sh{
            prefix=""
            name="$kak_bufname"
            max_length=$(( $kak_window_width * 3 / 5 ))
            while (( ${#name} > $max_length )); do
                if [[ "$name" = */* ]]; then
                    prefix=".../"
                    name=${name#*/}
                else
                    break
                fi
            done
            printf "%s%s" "$prefix" "$name"
        }
    }

    hook window WinSetOption readonly=true %{
        set-option window modeline_buffer_status " "
    }

    hook window ModeChange .*:.*:(.*) %{
        set-option window modeline_window_mode %sh{
            echo $kak_hook_param_capture_1 \
                | sed -e "s/next-key\[\(.*\)\]/\1/" \
                | sed -e "s/user\.//" \
                | sed -e "s/normal//"
        }
    }

    hook window RawKey .* %{
        set-option window modeline_selections %sh{
            selections=( $kak_selections_desc )
            cursors=${#selections[@]}
            if (( $cursors > 1 )); then
                printf "☐ $cursors  "
            fi
        }
    }

    build-modeline
    hook window WinDisplay .* build-modeline
    hook window FocusIn .* build-modeline
    hook window FocusOut .* build-modeline-unfocused
}
