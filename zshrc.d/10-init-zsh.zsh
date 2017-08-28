setopt NO_NOMATCH

export fpath=("$ZDOTDIR/completions" $fpath)

autoload -U compinit
compinit
