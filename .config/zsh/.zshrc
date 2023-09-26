# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# for wezterm
# source $ZRCDIR/wezterm.sh

PS1="%{$fg[cyan]%}[${USER}@${HOST%%.*} %1~]%(!.#.$)${reset_color} "

# base
source $ZRCDIR/base.zsh

# plugin
eval "$(sheldon source)"

# alias
source $ZRCDIR/alias.zsh

# function
source $ZRCDIR/function.zsh

# localfunction
if [ -f ~/.localfunction.zsh ]; then
	source ~/.localfunction.zsh
fi

