#!/bin/sh

tmux send-keys -t vim:1.0 Escape ":tabnew $1" C-m
