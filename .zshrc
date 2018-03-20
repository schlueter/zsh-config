# Source environment first
source "$ZDOTDIR/zshenv"
source "$ZDOTDIR/zenv"
# Source the zsh framework init first
source "$ZDOTDIR/.zprezto/init.zsh"
#fortune

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
[ -e "$ZDOTDIR/nvm/nvm.sh" ] && source "$ZDOTDIR/nvm/nvm.sh"
[ -e "$ZDOTDIR/z/z.sh" ] && source "$ZDOTDIR/z/z.sh"
