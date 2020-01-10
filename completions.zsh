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

for f in "$ZDOTDIR"/completions/_*
do
    source "$f" 2>/dev/null
done

brew_bash_completions_dir=/usr/local/etc/bash_completion.d
for f in "$brew_bash_completions_dir"/*
do
    source "$f"
done
