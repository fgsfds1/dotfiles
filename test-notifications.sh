#!/usr/bin/env bash
# Test script for dunst notifications

echo "Testing dunst notifications..."
echo

# Test normal notification
notify-send "Test Notification" "This is a normal priority notification" -i dialog-information

sleep 1

# Test low priority notification  
notify-send "Low Priority" "This is a low priority notification" -i dialog-information -u low

sleep 1

# Test critical notification
notify-send "Critical Alert" "This is a critical priority notification!" -i dialog-error -u critical

sleep 1

# Test notification with progress bar
notify-send "Download Progress" "Downloading file..." -i dialog-information -h int:value:75

sleep 1

# Test volume notification (app-specific styling)
notify-send -a "volume" "Volume" "Volume set to 50%" -i audio-volume-medium

sleep 1

# Test brightness notification (app-specific styling)  
notify-send -a "brightness" "Brightness" "Brightness set to 75%" -i display-brightness-symbolic

echo "Notification tests complete!"
echo "If dunst is running, you should have seen 6 different notifications."

