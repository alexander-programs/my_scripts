#!/bin/bash
mkdir -p ~/.local/bin
cp rename_tvshow.sh rename_movie.sh ~/.local/bin/
chmod +x ~/.local/bin/rename_tvshow.sh ~/.local/bin/rename_movie.sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
echo "Scripts installed! Restart your terminal or run 'source ~/.zshrc'"

