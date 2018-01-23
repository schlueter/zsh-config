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

# Disable stop/start of terminal on ctrl-s (maybe replace with ixany)
# see stty(1)
stty -ixon

pyenv() {
    eval "$( command pyenv init - )"
    pyenv "$@"
}

rbenv() {
    eval "$( command rbenv init - )"
    rbenv "$@"
}

nvm() {
		source "$ZDOTDIR/nvm/nvm.sh"
    nvm "$@"
}

source "$ZDOTDIR/z/z.sh"

# TODO this looks like a dup
autoload -U +X compinit && compinit

# TODO explain
autoload -U +X bashcompinit && bashcompinit

# bashcompinit must come before stack bash completion init
# Init stack completion
eval "$(stack --bash-completion-script stack)"
