#!/bin/sh
# NOTICE This file must be valid sh as it may be sourced by .xprofile or similar
if [ ! -d "$TMPDIR" ]
then
  TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

XDG_CONFIG_HOME="$HOME/.config"
TMPPREFIX="$TMPDIR/zsh"
EDITOR='vim'
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
PATH="$HOME/bin:$HOME/local/bin:$PATH"

export TMPDIR \
       TMPPREFIX \
       EDITOR \
       ZDOTDIR \
       PATH \
       XDG_CONFIG_HOME
