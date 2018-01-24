export CLASSPATH="$HOME/workspace/libs"
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-g -i -M -R -S -w -z-4 -F -X'
export LESSOPEN='|lesspreprocess %s'
export NVM_DIR="$HOME/.nvm"
export PAGER='less'
export PYTHONSTARTUP=~/.pythonrc
export VISUAL="$EDITOR"
export ZDOTDIR="$HOME/.config/zsh"

export PYENV_ROOT="$ZDOTDIR/pyenv"
export RBENV_ROOT="$ZDOTDIR/rbenv"

export path=(
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

if [[ ! -d "$TMPDIR" ]]
then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
