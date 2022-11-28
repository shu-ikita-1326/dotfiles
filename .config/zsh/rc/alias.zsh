# editor
alias n='nvim'
alias v='vim'

# tmux
alias t='tmux'
if [ -n "$TMUX" ]; then
	alias ide_v='tmux split-window -h -p 15; tmux split-window -v -p 66; tmux split-window -v -p 50; tmux select-pane -L; nvim;'
	alias ide_s='tmux split-window -v -p 15; tmux split-window -h -p 66; tmux split-window -h -p 50; tmux select-pane -U; nvim;'
fi

# git
alias g='git'
alias ga='git add'
alias gst='git status'

# ls
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'

# docker
alias dowatch='watch -t \''docker ps --all --format \"{{.Names}}: {{.Status}}\"\'''

# docker-compose
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

# cd
alias lab='cd ~/lab'
alias dot='cd ~/dotfiles'
