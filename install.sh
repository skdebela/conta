#!/bin/bash

set -e # Exit on any error

# Define paths explicitly for the current user
USER_HOME=$(eval echo ~${SUDO_USER:-$USER})
INSTALL_PATH="$USER_HOME/.local/share/conta"
SYMLINK_PATH="/usr/local/bin/conta"
CONFIG_DIR="$USER_HOME/.config/conta"

# Ensure required directories exist
mkdir -p "$INSTALL_PATH"
mkdir -p "$CONFIG_DIR"

# Copy all files to the install path
cp -r ./* "$INSTALL_PATH"

# Make main.sh executable
chmod +x "$INSTALL_PATH/main.sh"

# Create symbolic link with sudo to ensure system-level access
sudo ln -sf "$INSTALL_PATH/main.sh" "$SYMLINK_PATH"

# Copy help file for usage
cp "./help.txt" "$CONFIG_DIR/USAGE.txt"

# Display success message
echo "Conta installed successfully!"
echo "Data will be stored in: $INSTALL_PATH/data/contacts.txt"
echo "Run 'conta -h' for usage instructions."

