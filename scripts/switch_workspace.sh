#!/usr/bin/env bash
# 1: number of workspace to move to
# 2: 0-> switch workspace, 1->move windows and switch workspace

trgt=$1
do_window_move=$2
count=`yabai -m query --spaces --display | jq length`

# Create missing workspaces
if (( trgt > count )); then
  to_make=$(( trgt - count ))
  until (( to_make == 0 )); do
    yabai -m space --create;
    ((to_make--))
  done
fi

if ((do_window_move)); then
  yabai -m window --space $trgt
else
  yabai -m space --focus $trgt
fi
