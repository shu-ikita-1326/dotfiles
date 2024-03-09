#!/bin/bash

echo 'apt updating...'
sudo -E apt update > /dev/null

# For Telescope in nvim
if ! (type "sqlite" > /dev/null 2>&1); then
  echo 'Installing sqlite...'
  sudo -E apt install sqlite3 libsqlite3-dev > /dev/null
fi

brew bundle --file ~/dotfiles/installer/ubuntu/Brewfile

mise install

# For share clicpboard
sudo apt -y install xclip
