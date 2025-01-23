#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    return 1
fi

# Define the source and destination paths
MOTD_CONFIG_SRC="./motd-config"
MOTD_CONFIG_DEST="/etc/motd-config"
UPDATE_MOTD_SRC="./update-motd"
UPDATE_MOTD_DEST="/usr/bin/update-motd"
UPDATE_MOTD_D_SRC="./update-motd.d/*"
UPDATE_MOTD_D_DEST="/etc/update-motd.d/"

# Remove any existing files to prevent confusion
echo "Removing existing motd-config..."
rm -f "$MOTD_CONFIG_DEST"

echo "Removing existing update-motd..."
rm -f "$UPDATE_MOTD_DEST"

echo "Removing existing update-motd.d scripts..."
rm -rf "$UPDATE_MOTD_D_DEST"*

# Copy the motd-config file
echo "Copying motd-config to /etc..."
cp "$MOTD_CONFIG_SRC" "$MOTD_CONFIG_DEST"
chmod 644 "$MOTD_CONFIG_DEST"

# Copy the update-motd script
echo "Copying update-motd to /usr/bin..."
cp "$UPDATE_MOTD_SRC" "$UPDATE_MOTD_DEST"
chmod 755 "$UPDATE_MOTD_DEST"

# Copy the update-motd.d scripts
echo "Copying update-motd.d scripts to /etc/update-motd.d..."
cp $UPDATE_MOTD_D_SRC "$UPDATE_MOTD_D_DEST"
chmod 755 "$UPDATE_MOTD_D_DEST"*

# Run update-motd to compile for the first time with default settings
echo "Running update-motd for the first time..."
sudo /usr/bin/update-motd

echo "Installation complete."
