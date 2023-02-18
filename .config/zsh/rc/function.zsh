#---------------------------------------------------------------------#
#                   function                                          #
#---------------------------------------------------------------------#

# fzfをパスに追加
export PATH=$PATH:~/.fzf/bin
source ~/.fzf.zsh

# tmuxで使用している場合tmuxのポップアップでfzfを使用する
if [ -n "$TMUX" ]; then
	export FZF_TMUX=1
	export FZF_TMUX_OPTS="-p 80%"
fi

# fzfを使用したgit branchの切り替え
function select-git-switch() {
target_br=$(
git branch -a |
	fzf --exit-0 --layout=reverse --info=hidden --no-multi --preview-window="right,65%" --prompt="CHECKOUT BRANCH > " --preview="echo {} | tr -d ' *' | xargs git log --color=always" |
	head -n 1 |
	perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"

)
if [ -n "$target_br"  ]; then
	BUFFER="git switch $target_br"
	zle accept-line
fi

}
zle -N select-git-switch
bindkey "^g" select-git-switch # 「control + G」で実行

# fzfを使用してファイルをnvimで開く
function fnv() {
	local file
	file=$(find . | fzf)
	if [ -n "$file" ]; then
		nvim "$file"
	fi
}

# fzfを使用してパターンを含むファイルをnvimで開く
function fnvrg() {
	local file
	file=$(rg $1 | fzf | cut -d ":" -f 1)
	if [ -n "$file" ]; then
		nvim "$file"
	fi
}

# fzfを使用してコンテナ名を指定してdocker execを実行する
function dox() {
	local cname
	cname=$(docker ps --format "{{.Names}}" | fzf --reverse)
	if [ -n "$cname" ]; then
	docker exec -it "$cname" bash
	fi
}

# fzfを使用してコンテナ名を指定してdocker logを出力する
function dol() {
	local cname
	cname=$(docker ps --all --format "{{.Names}}" | fzf --reverse)
	if [ -n "$cname" ]; then
	docker logs --tail=500 "$cname"
	fi
}

# fzfを使用してコンテナ名を指定してdocker logを-fオプションで出力する
function dolf() {
	local cname
	cname=$(docker ps --format "{{.Names}}" | fzf --reverse)
	if [ -n "$cname" ]; then
	docker logs -f "$cname"
	fi
}

# fzfを使用して停止中のコンテナ名を任意の個数指定してdocker startする
function dostart() {
	local cnames
	cnames=$(docker ps --all --filter "status=exited" --filter "status=paused" --format "{{.Names}}" | fzf -m --bind=ctrl-a:toggle-all --reverse)
	if [ -n "$cnames" ]; then
		echo "$cnames" | xargs docker start
	fi
}

# fzfを使用して起動中のコンテナ名を任意の個数指定してdocker stopする
function dostop() {
	local cnames
	cnames=$(docker ps --all --filter "status=running" --format "{{.Names}}" | fzf -m --bind=ctrl-a:toggle-all --reverse)
	if [ -n "$cnames" ]; then
		echo "$cnames" | xargs docker stop
	fi
}

# fzfを使用して停止中のコンテナ名を任意の個数指定してdocker rmする
function dorm() {
	local cnames
	cnames=$(docker ps --all --filter "status=exited" --filter "status=paused" --format "{{.Names}}" | fzf -m --bind=ctrl-a:toggle-all --reverse)
	if [ -n "$cnames" ]; then
		echo "$cnames" | xargs docker rm
	fi
}

# Using fzf for git switch
function git-switch-fzf() {
  local branchname
  branchname=$(g --no-pager branch -a | grep -v HEAD | fzf --preview "echo {} | sed 's/^.* //g' | xargs git --no-pager log --oneline --graph -20 --color=always" | sed -e "s/^.* //g" -e "s/remotes\/[^\/]*\///g")
  if [ -n "$branchname" ]; then
    git switch "$branchname"
  fi
}

# fzfを使用してメイン作業ディレクトリリストから選択して移動する
function desk() {
	local dirname
	dirname=$(ls "$LAB" | fzf --reverse)
	if [ -n "$dirname" ]; then
		cd "$LAB/$dirname"
	fi
}

# fzfを使用してghqが管理しているディレクトリを選択して移動する
function ghq-fzf() {
  local dirname
  dirname=$(ghq list -p | fzf --reverse)
  if [ -n "$dirname" ]; then
    cd "$dirname"
  fi
}

# メモ機能
function memo() {
  local filename
  if [ -n "$1" ]; then
    case "$1" in
      "-n")
        if [ -n "$2" ]; then
          filename="$MEMODIR/$2"
          if [ -f "$filename" ]; then
            echo "$filename" is exists.
          else
            nvim "$filename"
          fi
        fi
        ;;
      "-l")
        filename=$(ls $MEMODIR | fzf --reverse)
        if [ -n "$filename" ]; then
            nvim "$MEMODIR/$filename"
        fi
        ;;
      *)
        echo "option is undefined."
    esac
  else
    echo "option require."
  fi
}
#---------------------------------------------------------------------#
#                   functions fin                                     #
#---------------------------------------------------------------------#
