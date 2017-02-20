case "$OSTYPE" in
    darwin*) export BROWSER='open';;
esac

LANG='en_US.UTF-8'
EDITOR='vim'
VISUAL="$EDITOR"
PAGER='less'
CLASSPATH="$HOME/workspace/libs"
LESS='-g -i -M -R -S -w -z-4 -F -X'
PYTHONSTARTUP=~/.pythonrc
NVM_DIR="$HOME/.nvm"
PYENV_ROOT="$HOME/.pyenv"

PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\" \
    -c ':AnsiEsc<CR>'"

path=("$HOME/bin" "$HOME/.local/bin"  "$PYENV_ROOT/bin" $path)

export LANG \
       NVM_DIR \
       EDITOR \
       VISUAL \
       PAGER \
       CLASSPATH \
       LESS \
       PATH \
       PAGER
