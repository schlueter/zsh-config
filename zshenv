if [[ ! -d "$TMPDIR" ]]
then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX="${TMPDIR%/}/zsh"
export EDITOR='vim'
export ZDOTDIR="$HOME/.config/zsh"
path=($HOME/bin $HOME/ubin /usr/local/bin $path)
export path
