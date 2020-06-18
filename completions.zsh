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
