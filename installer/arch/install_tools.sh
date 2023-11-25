#!/bin/bash

file_path="packages.txt"

while IFS= read -r line; do
    yay --noconfirm -S "$line"
done < "$file_path"
