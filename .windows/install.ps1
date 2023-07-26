# Install scoop if it is not installed
if (where.exe scoop 2> $null) {
	echo 'scoop is already.'
} else {
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
	iwr -useb get.scoop.sh | iex
}

# git
scoop install git

# add bucket
scoop bucket add versions
scoop bucket add extras

# vscode
scoop install vscode

# neovim
scoop install neovim-nightly

# zenhan
scoop install zenhan

# fzf
scoop install fzf

# python
scoop install python

# windows terminal
scoop install windows-terminal

# for nvim-treesitter
scoop install zig

# for telescope
scoop install ripgrep
