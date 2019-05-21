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



# From files
for f in aliases/*
do
    source "$f"
done

try_ssh_forever () {
    until ssh $@
    do
        printf '\33[2K\33[A'
    done
}


#!!! An alias doesn't work, use the function instead !!!
git () {
    # Don't break git if hub isn't installed yet
    if which hub >/dev/null 2>&1
    then
        hub $@
    else
        unset -f git
        git $@
    fi
}

gdv () {
    git diff -w "$@" | view -
}

gfg () {
    git ls-files | grep $@
}

compdef _git gdv=git-diff

git_primary_branch () {
    git rev-parse --symbolic-full-name origin
}

git_primary_branch_base () {
    local ref
    ref=$(git rev-parse --symbolic-full-name origin)
    if [[ $? != 0 ]]
    then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/remotes/origin/}
}

git_current_branch () {
    local ref
    ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
    if [[ $? != 0 ]]
    then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo "${ref#refs/heads/}"
}

git_cherry_pick_file () {
    git cherry-pick -n $1
    git reset HEAD
    git add $2
    git checkout $(git rev-parse --show-toplevel)
}

git_checkout_and_pull () {
    git checkout $1
    git pull
}

git_checkout_pull_request () {
    [[ -z "$3" ]] && remote=upstream || remote=$3
    [[ -z "$2" ]] && branch=PR$1 || branch=$2
    git fetch $remote pull/$1/head:$branch
    git checkout $branch
}

git_delete_branch_local_and_origin () {
    git branch --delete $1
    git push origin :$1
}

git_force_delete_branch_local_and_origin () {
    git branch --delete --force $1
    git push origin :$1
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
