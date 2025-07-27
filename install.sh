#!/bin/bash

# Define where to install scripts
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

# Copy all .sh files (non-hidden) to the install dir
cp ./*.sh "$INSTALL_DIR" || {
  echo "❌ Failed to copy scripts to $INSTALL_DIR"
  exit 1
}

# Make them executable
chmod +x "$INSTALL_DIR"/*.sh

# Detect user's shell
CURRENT_SHELL=$(basename "$SHELL")
case "$CURRENT_SHELL" in
  zsh) SHELL_CONFIG="$HOME/.zshrc" ;;
  bash) SHELL_CONFIG="$HOME/.bashrc" ;;
  fish) SHELL_CONFIG="$HOME/.config/fish/config.fish" ;;
  *)
    echo "⚠️ Unknown shell: $CURRENT_SHELL"
    echo "Please manually add $INSTALL_DIR to your PATH."
    exit 1
    ;;
esac

# Add to PATH if not already there
if ! grep -q "$INSTALL_DIR" "$SHELL_CONFIG"; then
  echo "" >> "$SHELL_CONFIG"
  if [[ "$CURRENT_SHELL" == "fish" ]]; then
    echo "set -gx PATH $INSTALL_DIR \$PATH" >> "$SHELL_CONFIG"
  else
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_CONFIG"
  fi
  echo "✅ Added $INSTALL_DIR to PATH in $SHELL_CONFIG"
else
  echo "ℹ️ $INSTALL_DIR already in PATH in $SHELL_CONFIG"
fi

echo "✅ All scripts installed!"
echo "🔄 Please restart your terminal or run: source $SHELL_CONFIG"
