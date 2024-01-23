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
if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# for wezterm
# source $ZRCDIR/wezterm.sh

PS1="%{$fg[cyan]%}[${USER}@${HOST%%.*} %1~]%(!.#.$)${reset_color} "

if (type "mise" > /dev/null 2>&1); then
  eval "$(mise activate zsh)"
fi

# base
source $ZRCDIR/base.zsh

# plugin
if (type "sheldon" > /dev/null 2>&1); then
  eval "$(sheldon source)"
fi

# alias
source $ZRCDIR/alias.zsh

# function
source $ZRCDIR/function.zsh

# localfunction
if [ -f ~/.localfunction.zsh ]; then
	source ~/.localfunction.zsh
fi

