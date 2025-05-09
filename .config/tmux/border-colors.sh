#!/bin/bash

pane_count=$(tmux list-panes | wc -l)

if [ "$pane_count" == 2 ];
then
	tmux set -g pane-border-style "fg=#93672e"
	tmux set -g pane-active-border-style "fg=#93672e"
else
	tmux set -g pane-border-style "fg=#93672e"
	tmux set -g pane-active-border-style "fg=#2e9367"
fi

