alias l='ls -l'
alias la='ls -a'

if which lsd >/dev/null
then
    alias ls=lsd
    alias lst='lsd --tree'
fi
