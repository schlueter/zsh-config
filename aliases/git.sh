#!/usr/bin/env zsh
## remote
alias gRl='git   remote --verbose'

## add
alias ga='git    add'
alias gap='git   add --patch'

## branch
alias gb='git    branch'
alias gsupo='git branch --set-upstream-to'
alias gsup='git  branch --set-upstream-to=origin/$(git_current_branch)'
alias gbr='git   branch --remotes --no-merged'
alias gbm='git   branch --remotes --merged'
alias gdl=git_delete_branch_local_and_origin
alias gdl!=git_force_delete_branch_local_and_origin

## checkout
alias gco='git   checkout'
alias gcb='git   checkout -b'
alias gch='git   checkout HEAD'
alias gcm='git   checkout $(git_primary_branch_base)'
alias gcml='git  checkout $(git_primary_branch_base) && git pull --prune'
alias gcol=git_checkout_and_pull
alias gcop=git_checkout_pull_request

## cherry-pick
alias gcp='git cherry-pick --signoff --gpg-sign'
alias gcpf=git_cherry_pick_file

## commit
alias gc='git   commit --gpg-sign --verbose'
alias gc!='git  commit --gpg-sign --verbose --amend'
alias gca='git  commit --gpg-sign --verbose --all'
alias gca!='git commit --gpg-sign --verbose --all --amend'
alias gcr='git  commit --gpg-sign --verbose --edit --file=.git/COMMIT_EDITMSG'

## clone
alias gcl='git clone --recursive'

## config
alias gcf='git config --list'

## clean
alias gclean='git clean -d --force'
alias gpristine='git reset --hard && git clean -dx --force'
## diff
alias gd='git diff'
alias gds='git diff --stat'
alias gdc='git diff --cached'
alias gdcs='git diff --cached --stat'
alias gdu='git diff $(git_primary_branch)'
alias gdus='git diff $(git_primary_branch) --stat'
alias gduc='git diff $(git_primary_branch) --cached'
alias gducs='git diff $(git_primary_branch) --cached --stat'

## diff-tree
alias gdt='git  diff-tree --no-commit-id --name-only -r'

## fetch
alias gf='git  fetch --all --prune'

## log
alias ghi="git log --graph --decorate=short --date=short --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s %C(red)%d%C(reset)'"
alias ghI="git log --graph --decorate=short --date=short --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%aE%C(reset) %s %C(red)%d%C(reset)'"

## pull
alias gl='git  pull --prune'

## push
alias gp='git push'
alias gp!='git push --force'
alias gppr='git push && gpr'

## branch shortcuts
alias gip=git_primary_branch
alias gib=git_current_branch
alias gipb=git_primary_branch_base

## rebase
alias grb='git               rebase --gpg-sign --signoff'
alias grba='git              rebase --abort'
alias grbc='git              rebase --continue'
alias grbi='git              rebase --gpg-sign --interactive --signoff'
alias grbs='git              rebase --skip'

## reset
alias grh='git  reset HEAD'
grhh () {
    read "?Are you sure? "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        git reset HEAD --hard
    else
        echo 'Aborted.'
    fi
}

## rm
alias grm='git rm'

## status
alias gs='git  status --short'
alias gsb='git status --short --branch'
alias gst='git status'

## stash
alias gtd='git stash drop'
alias gtp='git stash pop'
alias gts='git stash show'
alias gtt='git stash save --include-untracked'

## misc
alias gre=git-recent-refs
alias gah=git_annotated_history
alias grc=git_recent_changes
alias groot='git rev-parse --show-toplevel'

## Hub aliases
alias gw='git browse'
alias gpr='gh pr create'

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
    git remote show origin | awk '/.?.?HEAD branch:/{print $NF}'
}

git_current_branch () {
    git rev-parse --abbrev-ref HEAD
}

git_cherry_pick_file () {
    git cherry-pick --signoff --gpg-sign --no-commit "$1"
    git reset HEAD
    git add "$2"
    git checkout $(git rev-parse --show-toplevel)
}

git_checkout_and_pull () {
    git checkout "$1"
    git pull --prune
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

git_recent_changes () {
    git show --pretty=format:'%H %ai %an %s %d' $(
        git for-each-ref --sort=-committerdate refs \
          | head -"${1:-10}" \
          | cut -d' ' -f1
    ) | awk '/^[a-z0-9]{40} /'
}

git_recent_branches () {
    # Newlines matter here, this command pipeline will look strange as long as
    # sed is used.
    git reflog \
    | sed -En 's/.*moving from ([^ ]*) to ([^$]*)/\1\
\2/p' \
    | head "-${1:-100}" \
    | sort -u
}


