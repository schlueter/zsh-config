#!/usr/bin/env zsh
source "$ZDOTDIR/zshenv"
source "$ZDOTDIR/zenv"
source "$ZDOTDIR/.zprezto/init.zsh"

# See zshbuiltins(1)
typeset -gU cdpath fpath mailpath path

source "$ZDOTDIR/zsh-options.zsh"
source "$ZDOTDIR/vim-mode.zsh"
source "$ZDOTDIR/aliases.zsh"

# Initialize some things if they are present
[ $commands[pyenv] ] && eval "$( command pyenv init - )"
[ $commands[rbenv] ] && eval "$( command rbenv init - )"
[ -e "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -e "$Z_DIR/z.sh" ] && source "$Z_DIR/z.sh"

# Additional completions
if [ $commands[stack] ]
then
    autoload -U +X bashcompinit
    bashcompinit
    eval "$(stack --bash-completion-script stack)"
fi

[ $commands[kubectl] ] && eval "$(kubectl completion zsh)"

# Initialize the ssh-agent
if [ ! "$SSH_AUTH_SOCK" ]
then
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
    if ! pgrep ssh-agent >/dev/null || ! [ -e "$SSH_AUTH_SOCK" ]
    then
        rm -f $SSH_AUTH_SOCK
        eval "$(ssh-agent -a "$SSH_AUTH_SOCK")"
        ssh-add
    fi
fi

load_secrets () {
    local secrets_file
    secrets_file="$XDG_CONFIG_HOME/.secrets"
    [ -e "$secrets_file" ] && source "$secrets_file"
}

load_secrets
