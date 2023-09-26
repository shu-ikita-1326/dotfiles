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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
