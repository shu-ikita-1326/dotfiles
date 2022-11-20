# editor
alias n='nvim'

# tmux
alias ide='tmux split-window -v -p 15; tmux split-window -h -p 66; tmux split-window -h -p 50; tmux select-pane -U; nvim;'

# git
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
