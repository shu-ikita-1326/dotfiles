#!/usr/bin/bash

set -eu

IGNORE_PATTERN="^\.(git|windows)"

echo "Create dotfile links."
for dotfile in .??*; do
    [[ $dotfile =~ $IGNORE_PATTERN ]] && continue
    if [ -d "$dotfile" ]; then
        mv -v "$HOME/$dotfile" "$HOME/${dotfile}.bak"
        ln -snfv "$(pwd)/$dotfile" "$HOME/$dotfile"
    else
        ln -snfv "$(pwd)/$dotfile" "$HOME/$dotfile"
    fi
done

echo "Success."
