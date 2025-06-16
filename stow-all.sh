#!/bin/bash

DOTDIR=/home/mos/personal/dotfiles
TARGET=/home/mos

cd "$DOTDIR" || exit 1

for pkg in bash bin BraveSoftware ghostty hypr kitty nvim tmux zsh; do
	stow --dir="$DOTDIR" --target="$TARGET" "$pkg"
done
