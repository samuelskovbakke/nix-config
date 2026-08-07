  #!/usr/bin/env bash
# Script for keyboard layout switching with notifications

iDIR="$HOME/.config/swaync/icons"

# Get current layout from niri
get_layout() {
      niri msg keyboard-layouts | grep '^\s*\*' | grep -oP '\d+\s+\K.+'
}

# Get a friendly display name
get_layout_name() {
    case "$(get_layout)" in
        us) echo "English (US)" ;;
        dk) echo "Danish" ;;
        *)  echo "$(get_layout)" ;;
    esac
}

# Get icon (you can add a keyboard icon to your swaync icons dir)
get_icon() {
    case "$(get_layout)" in
        "English (US)") echo "$iDIR/flag-us.png" ;;
        "Danish")        echo "$iDIR/flag-dk.png" ;;
        *)               echo "$iDIR/keyboard.png" ;;
    esac
}

# Notify
# notify_user() {
#     notify-send -e \
#         -h string:x-canonical-private-synchronous:layout_notif \
#         -u low \
#         -i "$(get_icon)" \
#         " Keyboard Layout:" \
#         " $(get_layout_name)"
# }

# Switch layout
switch_next() {
    niri msg action switch-layout next #&& notify_user
}

switch_prev() {
    niri msg action switch-layout prev #&& notify_user
}

# Execute
if [[ "$1" == "--next" ]]; then
    switch_next
elif [[ "$1" == "--prev" ]]; then
    switch_prev
else
    get_layout_name
fi
