#!/bin/bash

# パッケージマネージャを最新に更新
apt update

# gitをインストール
if !(type "git" > /dev/null 2>&1); then
  apt install git
fi

# tigをインストール
if !(type "tig" > /dev/null 2>&1); then
  apt install tig
fi

# zshをインストール
if !(type "zsh" > /dev/null 2>&1); then
  apt install zsh
fi

# ripgrepをインストール
if !(type "rg" > /dev/null 2>&1); then
  apt install ripgrep
fi

# tmuxをインストール
if type "tmux" > /dev/null 2>&1; then
  run_install=false
else
  tmux_version=$(tmux -V)
  if "$tmux_version" == *3.2*; then
    run_install=false
  else
    run_install=true
  fi
fi
if "${run_install}"; then
  installer/tmux_3_2.sh
fi

# fzfをインストール
# zshでもキーバインドを有効化する場合はzshで~/.fzf/installを実行する
if !(type "fzf" > /dev/null 2>&1); then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# batをインストール
if !(type "bat" > /dev/null 2>&1); then
  apt install bat
fi
# batがbatcatとしてインストールされた場合にbatで呼び出せるようにする
if [ -f /usr/bin/batcat ]; then
  ln -s /usr/bin/batcat ~/.local/bin/bat
fi


# for Telescope in nvim
if !(type "sqlite" > /dev/null 2>&1); then
  apt install sqlite3 libsqlite3-dev
fi
