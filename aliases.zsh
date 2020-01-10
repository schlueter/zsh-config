# Misc
alias edot='dot -Tpng | feh --scale-down -'
alias .z='TASKS=1 source "${ZDOTDIR}"/.zshrc'
alias agrep='alias | grep'
alias allow='sudo xattr -d -r com.apple.quarantine'
alias fuck='sudo $(fc -ln -1)'
alias ish='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias sshr='ssh-keygen -R'
alias sshe='ssh -O exit'
alias ussh=try_ssh_forever
alias s=surf-manager

# From files
for f in "$ZDOTDIR"/aliases/* "$XDG_CONFIG_HOME"/shell_aliases/*
do
    source "$f"
done

try_ssh_forever () {
    until ssh $@
    do
        printf '\33[2K\33[A'
    done
}


use-gnu-tools () {
    export PATH="/usr/local/Cellar/gnu-sed/4.2.2/libexec/gnubin:/usr/local/Cellar/coreutils/8.25/libexec/gnubin/:$PATH"
}

realpath () {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

colors () {
    for i in {0..255}
    do
        printf "\x1b[38;5;${i}m${i}\n"
    done
}

git_recent_branches () {
    git reflog \
    | sed -En 's/.*moving from ([^ ]*) to ([^$]*)/\1\
\2/p' \
    | head "-${1:-100}" \
    | sort -u
}

agent () {
    eval `ssh-agent -s`
    ssh-add
}

brew () {
    env PATH=${PATH//$(pyenv root)\/shims:/} brew "$@"
}

used_git_aliases () {
    history 0 | awk '/\w*[0-9]*  g/ && !/(grep|awk|grub|ghc|groups|gem|pass|git|gpg|gdb)/ {print $2}' | sort -u
}

alias | grep gpa &>/dev/null && unalias gpa
