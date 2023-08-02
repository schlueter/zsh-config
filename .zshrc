#!/usr/bin/env zsh

###############################################################################
# The profile_startup functionality is only useful for profiling and debugging.
###############################################################################
profile_startup="$(if [ -f "$HOME"/profile-startup ]; then echo "yes"; else echo "no"; fi)"

if [ "$profile_startup" = yes ]
then

    zmodload zsh/datetime
    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '

    logfile=$(mktemp --tmpdir zsh_profile.XXXXXXXX)
    exec 3>&2 2>!$logfile

    setopt XTRACE
fi

source "$ZDOTDIR/zshenv"
source "$ZDOTDIR/zenv"
source "$ZDOTDIR/.zprezto/init.zsh"

# See zshbuiltins(1)
typeset -gU cdpath fpath mailpath path

source "$ZDOTDIR/zsh-options.zsh"
source "$ZDOTDIR/vim-mode.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/completions.zsh"

# Initialize some things if they are present
[ $commands[pyenv] ] && eval "$( command pyenv init - )"
[ $commands[rbenv] ] && eval "$( command rbenv init - )"
[ -e "$Z_DIR/z.sh" ] && source "$Z_DIR/z.sh"

# Initialize the ssh-agent
if [ ! "$SSH_AUTH_SOCK" ]
then
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
    if ! pgrep ssh-agent >/dev/null || ! [ -e "$SSH_AUTH_SOCK" ]
    then
        rm -f $SSH_AUTH_SOCK
        eval "$(ssh-agent -a "$SSH_AUTH_SOCK")"
    fi
fi

load_secrets () {
    local secrets_file
    secrets_file="$XDG_CONFIG_HOME/.secrets"
    [ -e "$secrets_file" ] && source "$secrets_file"
}

load_secrets

# depending on configuration outside this repo, npm may need secrets available
[ -e "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

(
    # Skip update if the system has been up less than 300 seconds
    [ "$(($(date -d "$(uptime -s)" +%s)+300))" -gt "$(date +%s)" ] && exit
    # Skip update if the zsh config has been updated in last day
    find ~/run/zsh_update -mmin +$((24 * 60 * 60)) >/dev/null 2>&1 || exit
    cd "$(dirname $0)" || (
        printf $'\x1b[38;5;202mError encountered cd\'ing to zsh config dir\n'; exit
    ); exit
    # Skip update if the zsh config repo is dirty
    git diff --exit-code >/dev/null || (
        printf '\x1b[38;5;202mzsh config is dirty\n'; exit
    ); exit
    if git pull >/dev/null 2>&1
    then
        printf '\x1b[38;5;46mSuccessfully pulled update to zsh config\n'; exit
    else
        printf '\x1b[38;5;160mFailed to pull update to zsh config\n'; exit
    fi
    mkdir ~/run && touch ~/run/zsh_update
) &!

if [ "$profile_startup" = yes ]
then
    unsetopt XTRACE
    exec 2>&3 3>&-
    printf '\x1b[38;5;90mProfile logged to %s\n' "$logfile"

fi
