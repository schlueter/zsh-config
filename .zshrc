for f in "${ZDOTDIR}"/.zshrc.d/*
do
    source $f
done
typeset -gU cdpath fpath mailpath path
