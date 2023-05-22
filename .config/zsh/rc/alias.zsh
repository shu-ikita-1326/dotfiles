# editor
alias n='nvim'
alias v='vim'

# tmux
alias t='tmux'
if [ -n "$TMUX" ]; then
	alias ide_v='tmux split-window -h -p 15; tmux split-window -v -p 66; tmux split-window -v -p 50; tmux select-pane -L; nvim;'
	alias ide_s='tmux split-window -v -p 15; tmux split-window -h -p 66; tmux split-window -h -p 50; tmux select-pane -U; nvim;'
	alias fzf='fzf-tmux -p80%'
fi

# git
alias g='git'
alias ga='git add'
alias gst='git status'
alias gsf='git-switch-fzf'

alias lg='lazygit'

# ls
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
if command -v exa >/dev/null 2>&1; then
  alias ll='exa -lamh --color=auto --icons --octal-permissions --time-style=long-iso --git'
  alias lt='exa -lamhT --level=2 --color=always --icons --octal-permissions --time-style=long-iso --git'
  # normal ll
  alias lln='ls -la'
fi

# docker
alias dowatch='watch -t \''docker ps --all --format \"{{.Names}}: {{.Status}}\"\'''

alias ld='lazydocker'

# docker-compose
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

# cd
alias lab='cd ~/lab'
alias dot='cd ~/dotfiles'
alias cdd='zd'

# emacs
alias emacsc="emacsclient -t -a ''"
alias emacsk="emacsclient -e '(kill-emacs)'"
