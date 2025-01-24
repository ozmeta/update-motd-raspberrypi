#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    return 1
fi

# Define the source and destination paths
MOTD_CONFIG="/etc/motd-config"
UPDATE_MOTD="/usr/bin/update-motd"
UPDATE_MOTD_D="/etc/update-motd.d/"

# Remove any existing files to prevent confusion
echo "Removing existing "$MOTD_CONFIG"..."
rm -f "$MOTD_CONFIG"

echo "Removing existing "$UPDATE_MOTD"..."
rm -f "$UPDATE_MOTD"

echo "Removing existing "$UPDATE_MOTD_D" scripts..."
rm -rf "$UPDATE_MOTD_D"*

# Copy the motd-config file
echo "Copying to $MOTD_CONFIG..."
cp ./"$MOTD_CONFIG" "$MOTD_CONFIG"
chmod 644 "$MOTD_CONFIG"

# Copy the update-motd script
echo "Copying to $UPDATE_MOTD..."
cp ./"$UPDATE_MOTD" "$UPDATE_MOTD"
chmod 755 "$UPDATE_MOTD"

# Copy the update-motd.d scripts
echo "Copying to $UPDATE_MOTD_D..."
cp -r ./"$UPDATE_MOTD_D"* "$UPDATE_MOTD_D"
chmod 755 "$UPDATE_MOTD_D"*

# Run update-motd to compile for the first time with default settings
echo "Running update-motd for the first time..."
sudo /usr/bin/update-motd

echo "Installation complete."
