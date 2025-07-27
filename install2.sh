#!/bin/bash

# --- Settings ---
REPO_URL="https://github.com/Alex-Codes-Here/my_scripts.git"
INSTALL_DIR="$HOME/my_scripts"

# --- Clone the repository ---
echo "Cloning repository into $INSTALL_DIR..."
git clone "$REPO_URL" "$INSTALL_DIR" || {
  echo "❌ Failed to clone repository."
  exit 1
}

cd "$INSTALL_DIR" || {
  echo "❌ Could not change directory."
  exit 1
}

# --- Make all .sh files executable ---
echo "Setting execute permissions..."
chmod +x *.sh

# --- Optional: Run a setup command ---
# echo "Installing dependencies..."
# ./setup.sh   # Uncomment if you have a setup script

echo "✅ Installation complete."
echo "You can now run your scripts from $INSTALL_DIR"

