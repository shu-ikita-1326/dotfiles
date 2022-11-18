#!/bin/bash

# パッケージマネージャを最新に更新
apt update

# gitをインストール
apt install git

# tigをインストール
apt install tig

# zshをインストール
apt install zsh

# ripgrepをインストール
apt install ripgrep

# tmuxをインストール
apt install tmux

# fzfをインストール
# zshでもキーバインドを有効化する場合はzshで~/.fzf/installを実行する
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
