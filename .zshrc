source "$ZDOTDIR/zshenv"
source "$ZDOTDIR/zenv"
source "$ZDOTDIR/.zprezto/init.zsh"

# See zshbuiltins(1)
typeset -gU cdpath fpath mailpath path

# Set zsh options
source "$ZDOTDIR/zsh-options.zsh"

# Configure vim mode for zsh
source "$ZDOTDIR/vim-mode.zsh"

# Load aliases
source "$ZDOTDIR/aliases.zsh"

autoload -U compinit
compinit

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Initialize some things if they are present
[ $commands[pyenv] ] && eval "$( command pyenv init - )"
[ $commands[rbenv] ] && eval "$( command rbenv init - )"
[ $commands[stack] ] && eval "$(stack --bash-completion-script stack)"
[ $commands[kubectl] ] && source <(kubectl completion zsh)
[ -e "$HOME/.config/nvm/nvm.sh" ] && source "$HOME/.config/nvm/nvm.sh"
[ -e "$HOME/.config/z/z.sh" ] && source "$HOME/.config/z/z.sh"

if [ ! "$SSH_AUTH_SOCK" ]
then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    if ! pgrep ssh-agent >/dev/null || ! [ -e "$SSH_AUTH_SOCK" ]
    then
        rm -f $SSH_AUTH_SOCK
        eval "$(ssh-agent -a $SSH_AUTH_SOCK)"
        ssh-add
    fi
fi

[ -e "$HOME/.secrets" ] && source "$HOME/.secrets"
