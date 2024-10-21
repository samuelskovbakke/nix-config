# Get the current brightness level of the keyboard backlight
current_brightness=$(brightnessctl --device='rgb:kbd_backlight' get)

# If the current brightness is greater than 0, turn it off. Otherwise, turn it on.
if [ "$current_brightness" -gt 0 ]; then
    brightnessctl --device='rgb:kbd_backlight' set 0
else
    brightnessctl --device='rgb:kbd_backlight' set 100%
fi

