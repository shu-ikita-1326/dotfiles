#!/bin/bash

file_path="$HOME/dotfiles/installer/arch/packages.txt"

while IFS= read -r line; do
    yay --noconfirm -S "$line"
done < "$file_path"
