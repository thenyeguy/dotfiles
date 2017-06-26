function notify -a title -a message \
        -d "A platform independ function for generating desktop notifications"
    if silent type osascript
        osascript -e "display notification \"$message\" with title \"$title\""
    else if silent type notify-send
        notify-send --icon terminal "$title" "$message"
    else
        echo "No supported notification function found." 2>&1
        return 1
    end
end
