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
bindkey '^Y' autosuggest-accept

export SHELL=/usr/bin/zsh
export LAB=~/lab

# labディレクトリが存在していなかったら作成する
if [ ! -d ~/lab ]; then
	mkdir ~/lab
fi

#---------------------------------------------------------------------#
#                   base setting fin                                  #
#---------------------------------------------------------------------#
