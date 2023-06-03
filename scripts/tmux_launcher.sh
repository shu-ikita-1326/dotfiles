#!/bin/bash
# tmuxが起動しているか確認
if [ -z "$TMUX" ]; then
  echo "Please use tmux"
  exit 1
fi

# fzfのインストールを確認
if ! command -v fzf >/dev/null 2>&1; then
  echo "fzf is not installed. Please install fzf."
  exit 1
fi

fifo="/tmp/tmux_input"

function tmux_input () {
  mkfifo -m o+w "$fifo"
  cat "$fifo" &
  tmux popup -E -T "$1" -h 3 "
  bash -c \"trap 'echo \\\"\\\" > $fifo; exit' INT; read -e input; echo \\\$input > $fifo\"
  "
  rm "$fifo"
}

function switch_session () {
  # tmuxの既存セッションから選択
  session=$(tmux list-sessions -F "#S" | fzf-tmux -w 60 -h 20 --reverse)
  if [ -n "$session" ]; then
    tmux switch-client -t "$session"
  fi
}

function delete_sessions () {
  # tmuxの既存セッションから複数選択
  sessions=$(tmux list-sessions -F "#S" | fzf-tmux -w 60 -h 20 --reverse -m)
  if [ -n "$sessions" ]; then
    echo "$sessions" | xargs -I{} tmux kill-session -t {}
  fi
}

function create_new_session () {
  # ユーザーに入力を求めて新しいtmuxセッションを作成
  session_name=$(tmux_input 'Enter new session name')
  if [ ! "$session_name" = "" ]; then
    tmux new-session -d -s "$session_name"
    tmux switch-client -t "$session_name"
  fi
}

function launch_cheat () {
  query=$(tmux_input 'Enter query ex)foo/buzz')
  # tldrの起動
  if [ ! "$query" = "" ]; then
    tmux popup -E -h 80% -w 80% "curl -s cheat.sh/$query | less -R"
  fi
}

function launch_man () {
  # manのインストールを確認
  if ! command -v man >/dev/null 2>&1; then
    echo "man is not installed. Please install man."
    exit 1
  fi
  command_name=$(tmux_input 'Enter command name')
  # manの起動
  # TODO:存在しないコマンドを入力されたときのハンドリング
  if [ ! "$command_name" = "" ]; then
    tmux popup -E -h 80% -w 80% "man $command_name"
  fi
}

function launch_tldr () {
  # tldrのインストールを確認
  if ! command -v tldr >/dev/null 2>&1; then
    echo "tldr is not installed. Please install tldr."
    exit 1
  fi
  # tldrの起動
  command_name=$(tmux_input 'Enter command name')
  if [ ! "$command_name" = "" ]; then
    tmux popup -E -h 80% -w 80% "tldr $command_name | less -R"
  fi
}

function launch_lazygit () {
  # lazygitのインストールを確認
  if ! command -v lazygit >/dev/null 2>&1; then
    echo "lazygit is not installed. Please install lazygit."
    exit 1
  fi
  # lazygitの起動
  tmux popup -d '#{pane_current_path}' -w90% -h90% -E 'lazygit'
}

function launch_lazydocker () {
  # lazydockerのインストールを確認
  if ! command -v lazydocker >/dev/null 2>&1; then
    echo "lazydocker is not installed. Please install lazydocker."
    exit 1
  fi
  # lazydockerの起動
  tmux popup -d '#{pane_current_path}' -w90% -h90% -E 'lazydocker'
}

function create_session_from_ghq () {
  # ghqのインストールを確認
  if ! command -v ghq >/dev/null 2>&1; then
    echo "ghq is not installed. Please install ghq."
    exit 1
  fi
  # ghqで管理されているリポジトリから選択して新しいtmuxセッションを作成
  if command -v onefetch >/dev/null 2>&1; then
    repository=$(ghq list --full-path | fzf-tmux -p 90% --reverse --preview 'onefetch {}')
  else
    repository=$(ghq list --full-path | fzf-tmux -w 60 -h 20 --reverse)
  fi
  if [ -n "$repository" ]; then
    session_name=$(basename "$repository")
    tmux new-session -Dd -s "$session_name" -c "$repository"
    tmux switch-client -t "$session_name"
  fi
}

function create_session_from_ssh () {
  if [ ! -f ~/.ssh/config ]; then
    echo "The ~/.ssh/config file does not exist. Please create the file."
    exit 1
  fi
  # .ssh/configからHostを選択して接続する
  host=$(awk '/^Host/ {print $2}' ~/.ssh/config | fzf-tmux -w 60 -h 20 --reverse)
  if [ -n "$host" ]; then
    exists=false
    for session in $(tmux ls | awk '{print $1}' | sed 's/://'); do
      if [ "$session" = "$host" ]; then
        exists=true
        break
      fi
    done
    session_name=$(basename "$host")
    tmux new-session -Dd -s "$session_name"
    tmux switch-client -t "$session_name"
    if ! "${exists}"; then
      tmux send-keys "ssh $host" C-m
    fi
  fi
}

function create_session_for_dotfiles () {
  if [ ! -d ~/dotfiles ]; then
    echo "The ~/dotfiles directory does not exist. Please create the directory."
    exit 1
  fi
  # .ssh/configからHostを選択して接続する
  directory="$HOME/dotfiles"
  if [ -n "$directory" ]; then
    session_name=$(basename "$directory")
    tmux new-session -Dd -s "$session_name" -c "$directory"
    tmux switch-client -t "$session_name"
  fi
}

function create_session_for_org () {
  if [ ! -d ~/org ]; then
    echo "The ~/org directory does not exist. Please create the directory."
    exit 1
  fi
  # .ssh/configからHostを選択して接続する
  directory="$HOME/org"
  if [ -n "$directory" ]; then
    session_name=$(basename "$directory")
    tmux new-session -Dd -s "$session_name" -c "$directory"
    tmux switch-client -t "$session_name"
  fi
}

function toggle_tmux_synchronize () {
  state=$(tmux show-window-options synchronize-panes | awk '{print $2}')
  if [ "$state" = "on" ]; then
    tmux set-window-option synchronize-panes off
    tmux display "synchronize off"
  else
    tmux set-window-option synchronize-panes on
    tmux display "synchronize on"
  fi
}

function create_session_from_z () {
  # zのインストールを確認
  if [ ! -f ~/.z ]; then
    echo "z is not installed. Please install z."
    exit 1
  fi
  # zに記録されているディレクトリから選択して新しいtmuxセッションを作成
  if command -v exa >/dev/null 2>&1; then
    directory=$(awk -F '|' '{print $1}' ~/.z | fzf-tmux -p 90% --reverse --preview 'exa -T --level=2 {}')
  else
    directory=$(z -l | fzf-tmux -w 100 -h 20 --reverse)
  fi
  if [ -n "$directory" ]; then
    session_name=$(basename "$directory")
    tmux new-session -Dd -s "$session_name" -c "$directory"
    tmux switch-client -t "$session_name"
  fi
}

function launch_chatgpt () {
  # nvimのインストールを確認
  if ! command -v nvim >/dev/null 2>&1; then
    echo "nvim is not installed. Please install nvim."
    exit 1
  fi
  # ChatGPTの起動
  # TODO:ChatGPTがnvimに入っていない場合のハンドリング
  tmux popup -E -h 80% -w 80% "nvim --cmd 'let from_shell=v:true' -c ChatGPT"
}

function open_tmux_popup () {
  tmux popup -E -h 80% -w 80%
}

# 選択肢の表示
PS3="Select an action: "
options=(
  "Switch to existing tmux session"
  "Delete tmux session"
  "Create new tmux session"
  "Create tmux session from ghq repository"
  "Create tmux session from z directory"
  "Create tmux session for ssh connection"
  "Create tmux session for dotfiles"
  "Create tmux session for org"
  "Launch cheat.sh"
  "Launch man"
  "Launch tldr"
  "Launch lazygit"
  "Launch lazydocker"
  "Launch ChatGPT on nvim"
  "Toggle tmux synchronize panes"
  "Open tmux popup"
)

# 機能の選択
selected_option=$(printf '%s\n' "${options[@]}" | fzf-tmux -w 60 -h 20 --reverse)
if [ -z "$selected_option" ]; then
  exit 0
fi
case $selected_option in
  "Switch to existing tmux session")
    switch_session
    ;;
  "Delete tmux session")
    delete_sessions
    ;;
  "Create new tmux session")
    create_new_session
    ;;
  "Launch cheat.sh")
    launch_cheat
    ;;
  "Launch man")
    launch_man
    ;;
  "Launch tldr")
    launch_tldr
    ;;
  "Launch lazygit")
    launch_lazygit
    ;;
  "Launch lazydocker")
    launch_lazydocker
    ;;
  "Create tmux session from ghq repository")
    create_session_from_ghq
    ;;
  "Create tmux session for ssh connection")
    create_session_from_ssh
    ;;
  "Create tmux session for dotfiles")
    create_session_for_dotfiles
    ;;
  "Create tmux session for org")
    create_session_for_org
    ;;
  "Toggle tmux synchronize panes")
    toggle_tmux_synchronize
    ;;
  "Create tmux session from z directory")
    create_session_from_z
    ;;
  "Launch ChatGPT on nvim")
    launch_chatgpt
    ;;
  "Open tmux popup")
    open_tmux_popup
    ;;
  *) echo "Invalid option";;
esac

