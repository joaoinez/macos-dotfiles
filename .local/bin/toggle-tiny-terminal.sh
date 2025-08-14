#!/bin/bash

current_command=$(ps -o command -t "$(tmux display-message -p '#{pane_tty}')")

if [[ "$current_command" == *"nvim"* ]]; then
  if tmux list-panes -F '#{window_zoomed_flag}' | grep -q 1; then
    tmux select-pane -D
  else
    tmux split-window -v -p 30 -c "#{pane_current_path}"
  fi
else
  tmux select-pane -U
  tmux resize-pane -Z
fi
