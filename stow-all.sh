#!/bin/bash

DOTDIR=/home/mos/Dotfiles
TARGET=/home/mos

cd "$DOTDIR" || exit 1

for pkg in bash bin awesome ghostty kitty nvim ; do
	stow --dir="$DOTDIR" --target="$TARGET" "$pkg"
done
