function main() {
    local f
    for f in "${ZDOTDIR}"/zshrc.d/*
    do
        source $f
    done
}

main
typeset -gU cdpath fpath mailpath path
