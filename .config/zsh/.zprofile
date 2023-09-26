# local bin
if [ -d ~/.local/bin ]; then
  export PATH=$PATH:~/.local/bin
fi

# localenv
if [ -f ~/.localenv.zsh ]; then
  source ~/.localenv.zsh
fi

# go bin
if [ -d ~/go/bin ]; then
  export PATH=$PATH:~/go/bin
fi

# linuxbrew
if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
fi
