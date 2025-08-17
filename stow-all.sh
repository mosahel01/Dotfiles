#!/bin/bash

DOTDIR=$HOME/Dotfiles
TARGET=$HOME

cd "$DOTDIR" || exit 1

# for pkg in alacritty awesome bash bin fish ghostty hypr ideavimrc kitty nvim rofi starship tmux waybar zed zsh; do
for pkg in alacritty bash hypr nvim rofi waybar; do
	stow --dir="$DOTDIR" --target="$TARGET" "$pkg"
done
