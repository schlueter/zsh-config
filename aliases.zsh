# Haskell
alias edot='dot -Tpng | feh --scale-down -'

# Vagrant
alias vb='vagrant box'
alias vd='vagrant destroy'
alias vd!='vagrant destroy -f'
alias vgs='vagrant global-status'
alias vh='vagrant halt'
alias vp='vagrant provision'
alias vr='vagrant reload'
alias vs='vagrant ssh'
alias vu='vagrant up'
alias vup='vagrant up --provision'
alias vun='vagrant up --no-provision'
alias vbu='vagrant box update'
alias vst='vagrant snapshot take'
alias vsl='vagrant snapshot list'
alias vsb='vagrant snapshot back'
alias vsd='vagrant snapshot delete'
alias vsg='vagrant snapshot go'

# Git
alias ga='git add'
## branch
alias gb='git    branch'
alias gsupo='git branch --set-upstream-to'
alias gsup='git  branch --set-upstream-to=origin/$(git_current_branch)'
alias gbr='git   branch -r --no-merged'
alias gbm='git   branch -r --merged'
alias gdl=git_delete_branch_local_and_origin
alias gdl!=git_force_delete_branch_local_and_origin
alias gdra='gb -r --merged | awk "!/master/{sub(\"origin/\", \"\", $1); print $0}" | xargs -n1 -I{} git push origin :{}'
## checkout
alias gco='git  checkout'
alias gcb='git  checkout -b'
alias gch='git  checkout HEAD'
alias gcm='gco $(git_primary_branch_base)'
alias gcml='git checkout master && git pull'
alias gcul='git checkout master && git pull upstream master'
alias gcol=git_checkout_and_pull
alias gcop=git_checkout_pull_request
## cherry-pick
alias gcp='git cherry-pick'
alias gcpf=git_cherry_pick_file
## commit
alias gc='git    commit --verbose'
alias gc!='git   commit --verbose --amend'
alias gca='git   commit --verbose --all'
alias gca!='git  commit --verbose --all --amend'
alias gcas='git  commit --verbose --all --signoff --no-edit'
## clone
alias gcl='git clone --recursive'
## config
alias gcf='git config --list'
## clean
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'
## diff
alias gd='git   diff'
alias gds='git  diff --stat'
alias gdc='git  diff --cached'
alias gdcs='git diff --cached --stat'
alias gdu='git  diff $(git_primary_branch)'
## diff-tree
alias gdt='git  diff-tree --no-commit-id --name-only -r'
## fetch
alias gf='git  fetch'
alias gfa='git fetch --all --prune'
## log
alias ghi="git log --graph --decorate=short --date=short --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s %C(red)%d%C(reset)'"
## pull
alias gl='git  pull'
alias glu='git pull origin $(gpbb)'
## push
alias gp='git push'
alias gp!='git push -f'
## branch shortcuts
alias gip=git_primary_branch
alias gib=git_current_branch
alias gipb=git_primary_branch_base
## rebase
alias grb='git               rebase'
alias grba='git              rebase --abort'
alias grbc='git              rebase --continue'
alias grbi='git              rebase --interactive'
alias grbs='git              rebase --skip'
alias grbu='git fetch && git rebase origin/$(git_primary_branch_base)'
## reset
alias grh='git  reset HEAD'
alias grhh='git reset HEAD --hard'
## rm
alias grm='git rm'
## status
alias gs='git  status -s'
alias gsb='git status -sb'
alias gst='git status'
## stash
alias gt='git  stash'
alias gtd='git stash drop'
alias gtp='git stash pop'
alias gts='git stash show'
## misc
alias gre=git_recent_branches

## Hub aliases
alias gpr='git pull-request'
alias gppr='git push && git pull-request'
alias gw='git browse'

# Random aliases
alias .z='TASKS=1 source "${ZDOTDIR}"/.zshrc'
alias agrep='alias | grep'
alias allow='sudo xattr -d -r com.apple.quarantine'
alias fuck='sudo $(fc -ln -1)'
alias ish='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

#!!! An alias doesn't work, use the function instead !!!
git () {
    hub $@
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
  git reflog | sed -En 's/.*moving from ([^ ]*) to ([^$]*)/\1 \2/p' | xargs -n 2 printf "%-$((COLUMNS/2-10))s %$((COLUMNS/2-10))s\n"
}

agent () {
    eval `ssh-agent -s`
    ssh-add
}

alias | grep gpa &>/dev/null && unalias gpa

