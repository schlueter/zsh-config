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
alias gre=git-recent-refs

## Hub aliases
alias gpr='git pull-request'
alias gppr='git push && git pull-request'
alias gw='git browse'


