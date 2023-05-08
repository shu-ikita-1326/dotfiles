#!/bin/bash

# パッケージマネージャを最新に更新
echo 'apt updating...'
sudo apt update > /dev/null

# gitをインストール
if !(type "git" > /dev/null 2>&1); then
  echo 'Installing git...'
  sudo apt install git > /dev/null
fi

# zshをインストール
if !(type "zsh" > /dev/null 2>&1); then
  echo 'Installing zsh...'
  sudo apt install zsh > /dev/null
fi

# neovim
if !(type "nvim" > /dev/null 2>&1); then
  echo 'Installing neovim...'
  brew install neovim > /dev/null
fi

# ripgrepをインストール
if !(type "rg" > /dev/null 2>&1); then
  echo 'Installing ripgrep...'
  brew install ripgrep > /dev/null
fi

# tmuxをインストール
if !(type "tmux" > /dev/null 2>&1); then
  echo 'Installing tmux...'
  brew install tmux > /dev/null
fi

# fzfをインストール
if !(type "fzf" > /dev/null 2>&1); then
  echo 'Installing fzf...'
  brew install fzf > /dev/null
fi

# batをインストール
if !(type "bat" > /dev/null 2>&1); then
  echo 'Installing bat...'
  brew install bat > /dev/null
fi

# for Telescope in nvim
if !(type "sqlite" > /dev/null 2>&1); then
  echo 'Installing sqlite...'
  sudo apt install sqlite3 libsqlite3-dev > /dev/null
fi

# lazygit
if !(type "lazygit" > /dev/null 2>&1); then
  echo 'Installing lazygit...'
  brew install jesseduffield/lazygit/lazygit > /dev/null
fi

# lazydocker
if !(type "lazydocker" > /dev/null 2>&1); then
  echo 'Installing lazydocker...'
  brew install lazydocker > /dev/null
fi

# go
if !(type "go" > /dev/null 2>&1); then
  echo 'Installing golang...'
    sudo add-apt-repository -y ppa:longsleep/golang-backports
    sudo apt update -y
    sudo apt install -y golang-go
fi

# ghq
if !(type "ghq" > /dev/null 2>&1); then
  echo 'Installing ghq...'
  brew install ghq > /dev/null
fi

# onefetch
if !(type "onefetch" > /dev/null 2>&1); then
  echo 'Installing onefetch...'
  brew install onefetch > /dev/null
fi

