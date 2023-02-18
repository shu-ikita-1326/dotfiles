#!/bin/bash

# パッケージマネージャを最新に更新
echo 'apt updating...'
sudo apt update > /dev/null 2>&1

# gitをインストール
if !(type "git" > /dev/null 2>&1); then
  echo 'Installing git...'
  sudo apt install git > /dev/null 2>&1
fi

# tigをインストール
if !(type "tig" > /dev/null 2>&1); then
  echo 'Installing tig...'
  sudo apt install tig > /dev/null 2>&1
fi

# zshをインストール
if !(type "zsh" > /dev/null 2>&1); then
  echo 'Installing zsh...'
  sudo apt install zsh > /dev/null 2>&1
fi

# neovim
if !(type "nvim" > /dev/null 2>&1); then
  echo 'Installing neovim...'
  sudo apt install python3-neovim > /dev/null 2>&1
  sudo add-apt-repository ppa:neovim-ppa/unstable > /dev/null 2>&1
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install neovim > /dev/null 2>&1
  sudo apt-get install python-dev python-pip python3-dev python3-pip > /dev/null 2>&1
fi

# ripgrepをインストール
if !(type "rg" > /dev/null 2>&1); then
  echo 'Installing fipgrep...'
  sudo apt install ripgrep > /dev/null 2>&1
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
  echo 'Installing tmux...'
  installer/tmux_3_2.sh > /dev/null 2>&1
fi

# fzfをインストール
# zshでもキーバインドを有効化する場合はzshで~/.fzf/installを実行する
if !(type "fzf" > /dev/null 2>&1); then
  echo 'Installing fzf...'
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null 2>&1
  ~/.fzf/install --key-bindings --completion --no-update-rc > /dev/null 2>&1
fi

# batをインストール
if !(type "bat" > /dev/null 2>&1); then
  echo 'Installing bat...'
  sudo apt install bat > /dev/null 2>&1
fi
# batがbatcatとしてインストールされた場合にbatで呼び出せるようにする
if [ -f /usr/bin/batcat ]; then
  ln -fs /usr/bin/batcat ~/.local/bin/bat > /dev/null 2>&1
fi


# for Telescope in nvim
if !(type "sqlite" > /dev/null 2>&1); then
  echo 'Installing sqlite...'
  sudo apt install sqlite3 libsqlite3-dev > /dev/null 2>&1
fi

# lazygit
if !(type "lazygit" > /dev/null 2>&1); then
  echo 'Installing lazygit...'
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" > /dev/null 2>&1
  sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit > /dev/null 2>&1
  rm lazygit.tar.gz > /dev/null 2>&1
fi

# lazydocker
if !(type "lazydocker" > /dev/null 2>&1); then
  echo 'Installing lazydocker...'
  curl -Lo lazydocker_install_update_linux.sh "https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh" > /dev/null 2>&1
  chmod +x lazydocker_install_update_linux.sh > /dev/null 2>&1
  ./lazydocker_install_update_linux.sh > /dev/null 2>&1
  rm ./lazydocker_install_update_linux.sh > /dev/null 2>&1
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
    go install github.com/x-motemen/ghq@latest
fi
