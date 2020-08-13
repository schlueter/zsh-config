#!/usr/bin/env zsh
if which kitty >/dev/null
then
    kitty + complete setup zsh | source /dev/stdin
fi
