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
  "Create tmux session for ssh connection"
  "Launch lazygit"
  "Launch lazydocker"
)

# 機能の選択
selected_option=$(printf '%s\n' "${options[@]}" | fzf)
case $selected_option in
  "Switch to existing tmux session")
    # tmuxの既存セッションから選択
    session=$(tmux list-sessions -F "#S" | fzf)
    if [ -n "$session" ]; then
      tmux switch-client -t "$session"
    fi
    ;;
  "Delete tmux session")
    # tmuxの既存セッションから複数選択
    sessions=$(tmux list-sessions -F "#S" | fzf -m)
    if [ -n "$sessions" ]; then
      echo "$sessions" | xargs -I{} tmux kill-session -t {}
    fi
    ;;
  "Create new tmux session")
    # ユーザーに入力を求めて新しいtmuxセッションを作成
    read -p "Enter session name: " session_name
    if [ -n "$session_name" ]; then
      tmux new-session -d -s "$session_name"
      tmux switch-client -t "$session_name"
    fi
    ;;
  "Launch lazygit")
    # lazygitのインストールを確認
    if ! command -v lazygit >/dev/null 2>&1; then
      echo "lazygit is not installed. Please install lazygit."
      exit 1
    fi
    # lazygitの起動
    lazygit
    ;;
  "Launch lazydocker")
    # lazydockerのインストールを確認
    if ! command -v lazydocker >/dev/null 2>&1; then
      echo "lazydocker is not installed. Please install lazydocker."
      exit 1
    fi
    # lazydockerの起動
    lazydocker
    ;;
  "Create tmux session from ghq repository")
    # ghqのインストールを確認
    if ! command -v ghq >/dev/null 2>&1; then
      echo "ghq is not installed. Please install ghq."
      exit 1
    fi
    # ghqで管理されているリポジトリから選択して新しいtmuxセッションを作成
    if command -v onefetch >/dev/null 2>&1; then
      repository=$(ghq list --full-path | fzf --preview 'onefetch {}')
    else
      repository=$(ghq list --full-path | fzf)
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
    host=$(awk '/^Host/ {print $2}' ~/.ssh/config | fzf)
    if [ -n "$host" ]; then
      session_name=$(basename "$host")
      tmux new-session -Dd -s "$session_name"
      tmux switch-client -t "$session_name"
      tmux send-keys "ssh $host" C-m
    fi
    ;;
  *) echo "Invalid option";;
esac

