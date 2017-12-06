# Source the zsh framework init first
source "$ZDOTDIR/.zprezto/init.zsh"

# See zshbuiltins(1)
typeset -gU cdpath fpath mailpath path

# Set zsh options
source "$ZDOTDIR/zsh-options.zsh"

# Configure vim mode for zsh
source "$ZDOTDIR/vim-mode.zsh"

# Load aliases
source "$ZDOTDIR/aliases.zsh"

# TODO explain
export fpath=("$ZDOTDIR/completions" $fpath)

# TODO explain
autoload -U compinit
compinit

# Disable stop/start of terminal on ctrl-s (maybe replace with ixany
# stty -ixon

# Init some script language managers
for init in rbenv pyenv
do
    if which $init >/dev/null
    then eval "$($init init -)"
    else echo "$init not available, ignoring..."
    fi
done

# Init stack
eval "$(stack --bash-completion-script stack)"

# Init the node version manager
source "$ZDOTDIR/nvm/nvm.sh"

# Load the z "jump around" cd replacement
source "$ZDOTDIR/z/z.sh"

# TODO this seems looks like a dup
autoload -U +X compinit && compinit

# TODO explain
autoload -U +X bashcompinit && bashcompinit
