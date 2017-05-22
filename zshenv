ZDOTDIR="$HOME/.config/zsh"

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]
then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi


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
RBENV_ROOT="$HOME/.rbenv"

path=("$HOME/bin" "$HOME/.local/bin" "$PYENV_ROOT/bin" "$RBENV_ROOT/bin" $path)

export CLASSPATH \
       EDITOR \
       LANG \
       LESS \
       LESSOPEN \
       NVM_DIR \
       PAGER \
       PAGER \
       PATH \
       VISUAL \
       ZDOTDIR
