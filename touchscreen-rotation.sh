#!/bin/bash

# Device name : Touchscreen of OneXPlayer X1
DEVICE_NAME="NVTK0603:00 0603:F001"
RULE_FILE="/etc/udev/rules.d/99-touchscreen-rotation.rules"

echo "=== OneXPlayer X1 Touchscreen Calibration Tester based on the current config screen ==="
echo "1) 90 Degree Clockwise"
echo "2) 90 Degree Counter-Clockwise"
echo "3) 180 Degree"
echo "4) Default "
echo "5) Exit"
read -p "Select (1-5): " choice

case $choice in
    1) MATRIX="0 1 0 -1 0 1" ;;
    2) MATRIX="0 -1 1 1 0 0" ;;
    3) MATRIX="-1 0 1 0 -1 1" ;;
    4) MATRIX="1 0 0 0 1 0" ;;
    5) exit ;;
    *) echo "No choice is selected"; exit ;;
esac

echo "Set the matrix to: $MATRIX"

# Write the new rules of touchscreen setting
echo "ACTION==\"add|change\", KERNEL==\"event*\", ATTRS{name}==\"$DEVICE_NAME\", ENV{LIBINPUT_CALIBRATION_MATRIX}=\"$MATRIX\"" | sudo tee $RULE_FILE

# Reload the new rules and then update
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "--- Finished. Please check your touchscreen ---"
#echo ": It it isn't changed, please lock/restart the system"
