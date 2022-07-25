#!/usr/bin/env bash

delete_all()
{
  empty_spaces=`yabai -m query --spaces | jq -re 'map(select(."windows" == [] and ."has-focus" == false).index) | reverse | .[] '`
  if [[ -n $empty_spaces ]]; then
    fullscreen_origins=`yabai -m query --spaces | jq -re 'map(select(."is-native-fullscreen" == true).index - 1) | .[]'`
    for n in $empty_spaces; do
      if ! [[ $fullscreen_origins =~ $n ]]; then
        yabai -m space $n --destroy
      fi
    done
  fi
}

delete_trailing()
{
  last=`yabai -m query --spaces | jq -re 'map(select(."windows" != [] or ."has-focus" == true).index) | max'`
  trailing_spaces=`yabai -m query --spaces | jq -re 'map(select(.index > '$last' and .windows == []).index) | .[]'`
  for n in $trailing_spaces; do
    yabai -m space $n --destroy
  done
}

delete_trailing
