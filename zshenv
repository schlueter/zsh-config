export CLASSPATH="$HOME/workspace/libs"
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-g -i -M -R -S -w -z-4 -F -X'
export LESSOPEN='|lesspreprocess %s'
export NVM_DIR="$HOME/.nvm"
export PAGER='less'
export PYENV_ROOT="$HOME/.pyenv"
export PYTHONSTARTUP=~/.pythonrc
export RBENV_ROOT="$HOME/.rbenv"
export VISUAL="$EDITOR"
export ZDOTDIR="$HOME/.config/zsh"
export path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$PYENV_ROOT/bin"
  "$RBENV_ROOT/bin"
  $path
)

case "$OSTYPE" in
    # linux*) ;;
    darwin*) export BROWSER='open';;
esac

if [[ ! -d "$TMPDIR" ]]
then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]
then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

