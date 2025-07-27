#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"
SHELL_CONFIG="$HOME/.zshrc"  # Change to .bashrc if needed

mkdir -p "$INSTALL_DIR"

# Copy all .sh files from current directory to ~/.local/bin
cp *.sh "$INSTALL_DIR"/

# Make sure they are executable
chmod +x "$INSTALL_DIR"/*.sh

# Add ~/.local/bin to PATH if not already there
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_CONFIG"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
  echo "Added ~/.local/bin to PATH in $SHELL_CONFIG"
else
  echo "~/.local/bin is already in PATH in $SHELL_CONFIG"
fi

echo "✅ All scripts installed! Restart your terminal or run 'source $SHELL_CONFIG'"

