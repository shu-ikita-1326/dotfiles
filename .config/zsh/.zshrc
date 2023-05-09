# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# for wezterm
source $ZRCDIR/wezterm.sh

PS1="%{$fg[cyan]%}[${USER}@${HOST%%.*} %1~]%(!.#.$)${reset_color} "

# base
source $ZRCDIR/base.zsh

# path
source $ZRCDIR/path.zsh

# plugin
source $ZRCDIR/plugin.zsh

# alias
source $ZRCDIR/alias.zsh

# function
source $ZRCDIR/function.zsh

# localenv
if [ -f ~/.localenv.zsh ]; then
	source ~/.localenv.zsh
fi

# localfunction
if [ -f ~/.localfunction.zsh ]; then
	source ~/.localfunction.zsh
fi

