function main() {
    local f
    for f in "${ZDOTDIR}"/zshrc.d/*
    do
        source $f
    done
}

source "$ZDOTDIR/.zprezto/init.zsh"
main
typeset -gU cdpath fpath mailpath path
