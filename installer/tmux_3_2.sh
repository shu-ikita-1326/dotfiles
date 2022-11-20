#!/bin/bash

version="3.2"

# 関連ファイルをダウンロード
sudo apt install git automake bison build-essential pkg-config libevent-dev libncurses5-dev

# gitからソースファイルをダウンロード
git clone -b "$version" https://github.com/tmux/tmux 

# build
cd tmux
./autogen.sh
./configure --prefix=/usr/local

make
make install

# 不要なファイルを削除
cd ../
rm -rf tmux
