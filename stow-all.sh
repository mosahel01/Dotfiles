#!/bin/bash

DOTDIR=/home/hoywd/personal/dotfiles
TARGET=/home/hoywd

cd "$DOTDIR" || exit 1

for pkg in bin ghostty hypr nvim rofi waybar zsh ; do
	stow --dir="$DOTDIR" --target="$TARGET" "$pkg"
done
