#!/usr/bin/env zsh
## remote
alias gRl='git remote -v'

## add
alias ga='git add'
alias gap='git add -p'

## branch
alias gb='git    branch'
alias gsupo='git branch --set-upstream-to'
alias gsup='git  branch --set-upstream-to=origin/$(git_current_branch)'
alias gbr='git   branch -r --no-merged'
alias gbm='git   branch -r --merged'
alias gdl=git_delete_branch_local_and_origin
alias gdl!=git_force_delete_branch_local_and_origin

## checkout
alias gco='git  checkout'
alias gcb='git  checkout -b'
alias gch='git  checkout HEAD'
alias gcm='gco $(git_primary_branch_base)'
alias gcml='gcm && git pull'
alias gcul='git checkout master && git pull upstream master'
alias gcol=git_checkout_and_pull
alias gcop=git_checkout_pull_request

## cherry-pick
alias gcp='git cherry-pick'
alias gcpf=git_cherry_pick_file

## commit
alias gc='git   commit --gpg-sign --verbose'
alias gc!='gc   --amend'
alias gca='gc   --all'
alias gca!='gc! --all'

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
alias gtt='git stash save --include-untracked'

## misc
alias gre=git-recent-refs
alias gah=git_annotated_history

## Hub aliases
alias gpr='git pull-request'
alias gppr='git push && gh pr create'
alias gw='git browse'

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
    git cherry-pick -n "$1"
    git reset HEAD
    git add "$2"
    git checkout $(git rev-parse --show-toplevel)
}

git_checkout_and_pull () {
    git checkout "$1"
    git pull
}

git_checkout_pull_request () {
    [ -z "$3" ] && remote=upstream || remote="$3"
    [ -z "$2" ] && branch=PR"$1" || branch="$2"
    git fetch "$remote" "pull/$1/head:$branch"
    git checkout "$branch"u
}

git_delete_branch_local_and_origin () {
    git branch --delete "$1" "$2"
    git push origin :"$1"
}

git_force_delete_branch_local_and_origin () {
    git branch --delete --force "$1"
    git push origin :"$1"
}

git_annotated_history () {
    files="$1"
    if ! [ "$files" ]
    then
        files="$(
            find . -mindepth 1 -maxdepth 1 \
                -not \( -wholename '*.git*' -type d \)
        )"
    fi
    filename_width=0
    while read -r filename
    do
        filename="${filename/.\/}"
        if [ "${#filename}" -gt "$filename_width" ]
        then
            filename_width="${#filename}"
        fi
    done <<<$files

    while read -r filename
    do
        filename="${filename/.\/}"
        info="$(git log -n 1 --relative-date --pretty=reference "$filename")"
        if ! [ $info ]
        then
            info='Untracked'
        fi
        printf "%-$((filename_width))s%s\n" "$filename" "$info"
    done <<<$files
}
