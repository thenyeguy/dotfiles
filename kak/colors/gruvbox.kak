# An adaptation of gruvbox using cterm colors and extended faces.

evaluate-commands %sh{
    fg="rgb:ebdbb2"
    bg="rgb:282828"

    red="rgb:d75f5f"
    green="rgb:afaf00"
    yellow="rgb:ffaf00"
    blue="rgb:87afaf"
    purple="rgb:d787af"
    aqua="rgb:87af87"
    orange="rgb:ff8700"

    faded_purple="rgb:af8787"

    gray1="rgb:3a3a3a"
    gray2="rgb:4e4e4e"
    gray3="rgb:585858"
    gray4="rgb:787878"

    brighter="rgba:ebdbb220"
    dimmer="rgba:28282850"

    function set_face() {
        printf "set-face global %s %s\n" "$1" "$2"
    }

    # Editor GUI
    # ‾‾‾‾‾‾‾‾‾‾

    set_face Default            $fg,$bg
    set_face LineNumbers        $gray3
    set_face LineNumberCursor   $yellow+b
    set_face LineNumbersWrapped $bg
    set_face MenuForeground     $gray2,$blue
    set_face MenuBackground     $fg,$gray2
    set_face MenuInfo           $bg
    set_face Information        $bg,$fg
    set_face Error              $bg,$red+F
    set_face StatusLine         $fg,$bg
    set_face StatusLineMode     $yellow+b
    set_face StatusLineInfo     $purple
    set_face StatusLineValue    $red
    set_face StatusCursor       $bg,$fg
    set_face Prompt             $yellow
    set_face MatchingChar       $fg,$gray3+b
    set_face BufferPadding      $gray2,$bg

    # Cursor & selections
    # ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

    set_face PrimaryCursor      $bg,$fg+fg
    set_face PrimaryCursorEol   $bg,$faded_purple+fg
    set_face PrimarySelection   default,$gray3+g

    set_face SecondaryCursor    $bg,$gray4+fg
    set_face SecondaryCursorEol $fg,$gray4+fg
    set_face SecondarySelection $dimmer,$brighter

    # General highlighting
    # ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

    set_face MatchingChar default,$gray3+bg
    set_face Todo         $yellow+bf
    set_face Whitespace   $gray3
    set_face WrapMarker   $gray3

    # Code highlighting
    # ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

    set_face value     $purple
    set_face type      $yellow
    set_face variable  $blue
    set_face module    $purple
    set_face function  $aqua+b
    set_face string    $green
    set_face keyword   $red
    set_face operator  $red
    set_face attribute $orange
    set_face comment   $gray4
    set_face meta      $aqua
    set_face builtin   $fg+b
}
