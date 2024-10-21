# Path to the file that stores the touchpad state
TOUCHPAD_STATE_FILE="$HOME/.touchpad_state"

# Read the current state from the file
if [ -f $TOUCHPAD_STATE_FILE ]; then
    TOUCHPAD_ENABLED=$(< "$TOUCHPAD_STATE_FILE")
else
    # Default to enabled if the state file does not exist
    TOUCHPAD_ENABLED=1
fi
# Toggle the touchpad state
if [ $TOUCHPAD_ENABLED -eq 1 ]; then
    hyprctl keyword 'device[elan0412:00-04f3:3162-touchpad]:enabled' 'false'
    TOUCHPAD_ENABLED=0
else
    hyprctl keyword 'device[elan0412:00-04f3:3162-touchpad]:enabled' 'true'
    TOUCHPAD_ENABLED=1
fi

# Save the new state to the file
echo $TOUCHPAD_ENABLED > "$TOUCHPAD_STATE_FILE"