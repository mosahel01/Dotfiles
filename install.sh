#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Dotfiles..."

# alacritty
mkdir -p "$HOME/.config/alacritty"
ln -sfn "$DOTFILES/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
echo "✓ symlinked alacritty"

# nvim
ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim"
echo "✓ symlinked nvim"

# zsh
ln -sfn "$DOTFILES/zsh" "$HOME/.config/zsh"
echo "✓ symlinked zsh"

# tmux
ln -sfn "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
echo "✓ symlinked tmux"

# fonts
mkdir -p "$HOME/.config/fontconfig"
ln -sfn "$DOTFILES/fonts.conf" "$HOME/.config/fontconfig/fonts.conf"
echo "✓ symlinked fontconfig"

echo "✓ dotfiles installed"
