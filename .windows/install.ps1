# scoopがインストールされていなかったらインストールする
if (where.exe scoop 2> $null) {
	echo 'scoop is already.'
} else {
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
	iwr -useb get.scoop.sh | iex
}

# git
scoop install git

#bucketを追加
scoop bucket add versions
scoop bucket add extras

# vscode
scoop install vscode

# neovim
scoop install neovim

# zenhan
scoop install zenhan

# fzf
scoop install fzf

# python
scoop install python
