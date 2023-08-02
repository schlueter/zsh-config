#!/usr/bin/env zsh
alias l='ls -l'
alias la='ls -a'

if command -v lsd >/dev/null
then
    alias ls=lsd
    alias lst='ls --tree -a -I .git'
fi
