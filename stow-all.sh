#!/bin/bash

DOTDIR=/home/mos/Dotfiles
TARGET=/home/mos

cd "$DOTDIR" || exit 1

# for pkg in bash bin awesome ghostty kitty nvim ; do
# for pkg in awesome bash bin ghostty kitty nvim zsh ; do
# for pkg in tmux ; do
for pkg in awesome bash bin ghostty hypr kitty nvim rofi tmux waybar zsh ; do
	stow --dir="$DOTDIR" --target="$TARGET" "$pkg"
done
