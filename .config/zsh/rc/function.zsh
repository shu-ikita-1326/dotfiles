#---------------------------------------------------------------------#
#                   function                                          #
#---------------------------------------------------------------------#

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
    shell=$(echo 'bash\nsh' | fzf --reverse)
    if [ -n "$shell" ]; then
      docker exec -it "$cname" "$shell"
    fi
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
  if command -v onefetch >/dev/null 2>&1; then
    dirname=$(ghq list -p | fzf --reverse --preview 'onefetch {}')
  else
    dirname=$(ghq list -p | fzf --reverse)
  fi
  if [ -n "$dirname" ]; then
    cd "$dirname"
    zle accept-line
  fi
}

# 過去にcdで移動したディレクトリをfzfで絞り込んで移動する
function cdr-fzf() {
  local target_dir
  target_dir=$(cdr -l | awk '{print $2}'| fzf )
  if [ -n "$target_dir" ]; then
    target_dir=$(eval echo "$target_dir")
    cd "$target_dir"
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

# ディレクトリ移動まとめ
# zdd - cd to selected directory
zdd() {
  local dir
  dir="$(
    find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2> /dev/null \
      | fzf +m \
          --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-v:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-v) (sort:ctrl-x)' \
  )" || return
  cd "$dir" || return
}

# zda - including hidden directories
zda() {
  local dir
  dir="$(
    find "${1:-.}" -type d 2> /dev/null \
      | fzf +m \
          --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-v:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-v) (sort:ctrl-x)' \
  )" || return
  cd "$dir" || return
}

# zdr - cd to selected parent directory
zdr() {
  local dirs=()
  local parent_dir

  get_parent_dirs() {
    if [[ -d "$1" ]]; then dirs+=("$1"); else return; fi
    if [[ "$1" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo "$_dir"; done
    else
      get_parent_dirs "$(dirname "$1")"
    fi
  }

  parent_dir="$(
    get_parent_dirs "$(realpath "${1:-$PWD}")" \
      | fzf +m \
          --preview 'tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-v:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-v) (sort:ctrl-x)' \
  )" || return

  cd "$parent_dir" || return
}

# zst - cd into the directory from stack
zst() {
  local dir
  dir="$(
    dirs \
      | sed 's#\s#\n#g' \
      | uniq \
      | sed "s#^~#$HOME#" \
      | fzf +s +m -1 -q "$*" \
            --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
            --preview-window='right:hidden:wrap' \
            --bind=ctrl-v:toggle-preview \
            --bind=ctrl-x:toggle-sort \
            --header='(view:ctrl-v) (sort:ctrl-x)' \
  )"
  # check $dir exists for Ctrl-C interrupt
  # or change directory to $HOME (= no value cd)
  if [[ -d "$dir" ]]; then
    cd "$dir" || return
  fi
}

# zdf - cd into the directory of the selected file
zdf() {
  local file
  file="$(fzf +m -q "$*" \
           --preview="${FZF_PREVIEW_CMD}" \
           --preview-window='right:hidden:wrap' \
           --bind=ctrl-v:toggle-preview \
           --bind=ctrl-x:toggle-sort \
           --header='(view:ctrl-v) (sort:ctrl-x)' \
       )"
  cd "$(dirname "$file")" || return
}

# zz - selectable cd to frecency directory
zz() {
  local dir

  dir="$(
    fasd -dl \
      | fzf \
          --tac \
          --reverse \
          --select-1 \
          --no-sort \
          --no-multi \
          --tiebreak=index \
          --bind=ctrl-x:toggle-sort \
          --query "$*" \
          --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-v:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-v) (sort:ctrl-x)' \
  )" || return

  cd "$dir" || return
}

# zd - cd into selected directory with options
# The super function of zdd, zda, zdr, zst, zdf, zz
zd() {
  read -r -d '' helptext <<EOF
usage: zd [OPTIONS]
  zd: cd to selected options below
OPTIONS:
  -d [path]: Directory (default)
  -a [path]: Directory included hidden
  -r [path]: Parent directory
  -s [query]: Directory from stack
  -f [query]: Directory of the selected file
  -z [query]: Frecency directory
  -h: Print this usage
EOF

  usage() {
    echo "$helptext"
  }

  if [[ -z "$1" ]]; then
    # no arg
    zdd
  elif [[ "$1" == '..' ]]; then
    # arg is '..'
    shift
    zdr "$1"
  elif [[ "$1" == '-' ]]; then
    # arg is '-'
    shift
    zst "$*"
  elif [[ "${1:0:1}" != '-' ]]; then
    # first string is not -
    zdd "$(realpath "$1")"
  else
    # args is start from '-'
    while getopts darfszh OPT; do
      case "$OPT" in
        d) shift; zdd  "$1";;
        a) shift; zda "$1";;
        r) shift; zdr "$1";;
        s) shift; cdr-fzf "$*";;
        f) shift; zdf "$*";;
        z) shift; zz  "$*";;
        h) usage; return 0;;
        *) usage; return 1;;
      esac
    done
  fi
}

zle -N ghq-fzf
bindkey "^g" ghq-fzf # 「control + G」で実行

#zsh cdrをアクティブ化
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# cdr config
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

#---------------------------------------------------------------------#
#                   functions fin                                     #
#---------------------------------------------------------------------#
