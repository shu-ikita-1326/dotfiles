#---------------------------------------------------------------------#
#                   base setting                                      #
#---------------------------------------------------------------------#

# 履歴設定
HISTFILE="${ZDATADIR}/zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

if [ ! -d "${ZDATADIR}" ]; then
	mkdir "${ZDATADIR}"
fi
if [ ! -d "${ZCACHEDIR}" ]; then
	mkdir "${ZCACHEDIR}"
fi

# キーバインド
bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^ ' autosuggest-execute
bindkey '^Y' autosuggest-accept

export SHELL=/usr/bin/zsh
export LAB=~/lab
export NOTEDIR=~/note
export MINUTESDIR=~/minutes
export CHEATDIR=~/cheat

# labディレクトリが存在していなかったら作成する
if [ ! -d ~/lab ]; then
	mkdir ~/lab
fi

# zsh cdr履歴ディレクトリが存在していないかったら作成する
if [ ! -d ~/.cache/shell ]; then
  mkdir -p ~/.cache/shell
fi

# golang
export PATH=$PATH:~/go/bin
export GOPATH=~/go

# go/srcディレクトリが存在していなかったら作成する
if [ ! -d ~/go/src ]; then
	mkdir -p ~/go/src
fi

# noteディレクトリが存在していなかったら作成する
if [ ! -d "$NOTEDIR" ]; then
	mkdir "$NOTEDIR" 
fi

# minutesディレクトリが存在していなかったら作成する
if [ ! -d "$MINUTESDIR" ]; then
	mkdir "$MINUTESDIR" 
fi

# cheatディレクトリが存在していなかったら作成する
if [ ! -d "$CHEATDIR" ]; then
	mkdir "$CHEATDIR" 
fi
#---------------------------------------------------------------------#
#                   base setting fin                                  #
#---------------------------------------------------------------------#
