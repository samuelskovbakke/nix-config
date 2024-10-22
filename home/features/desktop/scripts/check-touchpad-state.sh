TOUCHPAD_STATE_FILE="$HOME/.touchpad_state"

if [ -f $TOUCHPAD_STATE_FILE ]; then
    state=$(< "$TOUCHPAD_STATE_FILE")
fi

# Set the touchpad state
if [ $state -eq 1 ]; then
    hyprctl keyword 'device[elan0412:00-04f3:3162-touchpad]:enabled' 'true'
else
    hyprctl keyword 'device[elan0412:00-04f3:3162-touchpad]:enabled' 'false'
fi