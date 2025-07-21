#!/bin/bash

DOTDIR=$HOME/Dotfiles
TARGET=$HOME

cd "$DOTDIR" || exit 1

# for pkg in  alacritty bin ghostty hypr kitty nvim rofi tmux waybar zsh ; do
for pkg in alacritty awesome bash bin ghostty hypr ideavimrc kitty nvim rofi tmux waybar zed zsh; do
	stow --dir="$DOTDIR" --target="$TARGET" "$pkg"
done
