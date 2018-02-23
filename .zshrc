export CLASSPATH="$HOME/workspace/libs"
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-g -i -M -R -S -w -z-4 -F -X'
export LESSOPEN='|lesspreprocess %s'
export NVM_DIR="$HOME/.nvm"
export PAGER='less'
export PYTHONSTARTUP=~/.pythonrc
export VISUAL="$EDITOR"

export PYENV_ROOT="$ZDOTDIR/pyenv"
export RBENV_ROOT="$ZDOTDIR/rbenv"

path=(
  "$HOME/bin"
  "$HOME/ubin"
  "$HOME/.local/bin"
  "$PYENV_ROOT/bin"
  "$RBENV_ROOT/bin"
  "$HOME/.cargo/bin"
  /usr/local/bin
  $path
)

case "$OSTYPE" in
    linux*) true;;
    darwin*) export BROWSER='open';;
esac

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
#export fpath=( "$ZDOTDIR/completions" $fpath )

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

pyenv >/dev/null 2>&1

source "$ZDOTDIR/z/z.sh"

# TODO this looks like a dup
autoload -U +X compinit && compinit

# TODO explain
autoload -U +X bashcompinit && bashcompinit

# bashcompinit must come before stack bash completion init
# Init stack completion
eval "$(stack --bash-completion-script stack)"

# kubectl completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
