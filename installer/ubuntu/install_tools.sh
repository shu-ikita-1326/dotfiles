#!/bin/bash

# パッケージマネージャを最新に更新
echo 'apt updating...'
sudo -E apt update > /dev/null

# for Telescope in nvim
if ! (type "sqlite" > /dev/null 2>&1); then
  echo 'Installing sqlite...'
  sudo -E apt install sqlite3 libsqlite3-dev > /dev/null
fi

brew bundle --file ~/dotfiles/installer/ubuntu/Brewfile

mise install
