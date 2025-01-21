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

# Set environment variables
# Check if CONTA_DATA_HOME is set, otherwise define it
if ! grep -q "CONTA_DATA_HOME" "$HOME/.bashrc"; then
    echo "export CONTA_DATA_HOME=\"$INSTALL_PATH/data/contacts.txt\"" >> "$HOME/.bashrc"
    echo "CONTA_DATA_HOME environment variable set in .bashrc"
else
    echo "CONTA_DATA_HOME is already set in .bashrc"
fi

# Check if CONTA_CONFIG_DIR is set, otherwise define it
if ! grep -q "CONTA_CONFIG_DIR" "$HOME/.bashrc"; then
    echo "export CONTA_CONFIG_DIR=\"$CONFIG_DIR\"" >> "$HOME/.bashrc"
    echo "CONTA_CONFIG_DIR environment variable set in .bashrc"
else
    echo "CONTA_CONFIG_DIR is already set in .bashrc"
fi

# Reload .bashrc to apply changes immediately
source "$HOME/.bashrc"

# Display success message
echo "Conta installed successfully!"
echo "Data will be stored in: $INSTALL_PATH/data/contacts.txt"
echo "Run 'conta -h' for usage instructions."
