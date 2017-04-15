case "$OSTYPE" in
    darwin*) export BROWSER='open';;
esac

LANG='en_US.UTF-8'
EDITOR='vim'
VISUAL="$EDITOR"
PAGER='less'
CLASSPATH="$HOME/workspace/libs"
LESS='-g -i -M -R -S -w -z-4 -F -X'
LESSOPEN='|lesspreprocess %s'
PYTHONSTARTUP=~/.pythonrc
NVM_DIR="$HOME/.nvm"
PYENV_ROOT="$HOME/.pyenv"

path=("$HOME/bin" "$HOME/.local/bin"  "$PYENV_ROOT/bin" $path)

export LANG \
       NVM_DIR \
       EDITOR \
       VISUAL \
       PAGER \
       CLASSPATH \
       LESS \
       LESSOPEN \
       PATH \
       PAGER
