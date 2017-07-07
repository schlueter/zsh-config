function main() {
    local f
    for f in "${ZDOTDIR}"/zshrc.d/*
    do
        source $f
    done
}

main
source "$ZDOTDIR/.zprezto/init.zsh"
typeset -gU cdpath fpath mailpath path
