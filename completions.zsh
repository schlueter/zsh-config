autoload -Uz compinit && compinit
autoload -U +X bashcompinit
bashcompinit

[ $commands[stack] ] && {
    eval "$(stack --bash-completion-script stack)"
}
[ $commands[helm] ] && {
    eval "$(helm completion zsh)"
}
[ $commands[kubectl] ] && {
    eval "$(kubectl completion zsh)"
}

for f in "$ZDOTDIR"/completions/{_*,*.bash}
do
    source "$f" 2>/dev/null
done
