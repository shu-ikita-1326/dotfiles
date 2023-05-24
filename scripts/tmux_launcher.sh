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
  "Launch tldr"
  "Launch lazygit"
  "Launch lazydocker"
  "Toggle tmux synchronize panes"
)

# 機能の選択
selected_option=$(printf '%s\n' "${options[@]}" | fzf-tmux -w 60 -h 20 --reverse)
if [ -z "$selected_option" ]; then
  exit 0
fi
case $selected_option in
  "Switch to existing tmux session")
    # tmuxの既存セッションから選択
    session=$(tmux list-sessions -F "#S" | fzf-tmux -w 60 -h 20 --reverse)
    if [ -n "$session" ]; then
      tmux switch-client -t "$session"
    fi
    ;;
  "Delete tmux session")
    # tmuxの既存セッションから複数選択
    sessions=$(tmux list-sessions -F "#S" | fzf-tmux -w 60 -h 20 --reverse -m)
    if [ -n "$sessions" ]; then
      echo "$sessions" | xargs -I{} tmux kill-session -t {}
    fi
    ;;
  "Create new tmux session")
    # ユーザーに入力を求めて新しいtmuxセッションを作成
    tmux popup -E 'trap "echo exit" 2
    read -p "Enter session name: " session_name
    if [ -n "$session_name" ]; then
      tmux new-session -d -s "$session_name"
      tmux switch-client -t "$session_name"
    fi
    '
    ;;
  "Launch tldr")
    # tldrのインストールを確認
    if ! command -v tldr >/dev/null 2>&1; then
      echo "tldr is not installed. Please install tldr."
      exit 1
    fi
    # tldrの起動
    tmux popup -E -h 80% -w 120 'trap "echo exit" 2
    read -p "Enter tldr words: " words
    if [ -n "$words" ]; then
      tldr $words | less -R
    fi
    '
    ;;
  "Launch lazygit")
    # lazygitのインストールを確認
    if ! command -v lazygit >/dev/null 2>&1; then
      echo "lazygit is not installed. Please install lazygit."
      exit 1
    fi
    # lazygitの起動
    tmux popup -d '#{pane_current_path}' -w90% -h90% -E 'lazygit'
    ;;
  "Launch lazydocker")
    # lazydockerのインストールを確認
    if ! command -v lazydocker >/dev/null 2>&1; then
      echo "lazydocker is not installed. Please install lazydocker."
      exit 1
    fi
    # lazydockerの起動
    tmux popup -d '#{pane_current_path}' -w90% -h90% -E 'lazydocker'
    ;;
  "Create tmux session from ghq repository")
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
    ;;
  "Create tmux session for ssh connection")
    if [ ! -f ~/.ssh/config ]; then
      echo "The ~/.ssh/config file does not exist. Please create the file."
      exit 1
    fi
    # .ssh/configからHostを選択して接続する
    host=$(awk '/^Host/ {print $2}' ~/.ssh/config | fzf-tmux -w 60 -h 20 --reverse)
    if [ -n "$host" ]; then
      session_name=$(basename "$host")
      tmux new-session -Dd -s "$session_name"
      tmux switch-client -t "$session_name"
      tmux send-keys "ssh $host" C-m
    fi
    ;;
  "Create tmux session for dotfiles")
    if [ ! -d ~/dotfiles ]; then
      echo "The ~/dotfiles directory does not exist. Please create the directory."
      exit 1
    fi
    # .ssh/configからHostを選択して接続する
    directory=$(echo ~/dotfiles)
    if [ -n "$directory" ]; then
      session_name=$(basename "$directory")
      tmux new-session -Dd -s "$session_name" -c "$directory"
      tmux switch-client -t "$session_name"
    fi
    ;;
  "Toggle tmux synchronize panes")
    state=$(tmux show-window-options synchronize-panes | awk '{print $2}')
    if [ "$state" = "on" ]; then
      tmux set-window-option synchronize-panes off
      tmux display "synchronize off"
    else
      tmux set-window-option synchronize-panes on
      tmux display "synchronize on"
    fi
    ;;
  "Create tmux session from z directory")
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
    ;;
  *) echo "Invalid option";;
esac

