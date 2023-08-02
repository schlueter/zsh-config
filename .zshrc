#!/usr/bin/env zsh

profile_startup="$(if [ -f "$HOME"/profile-startup ]; then echo "yes"; else echo "no"; fi)"

if [ "$profile_startup" = yes ]
then

    zmodload zsh/datetime
    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '

    logfile=$(mktemp --tmpdir zsh_profile.XXXXXXXX)
    exec 3>&2 2>!$logfile

    setopt XTRACE
fi

. "$ZDOTDIR/.zprezto/init.zsh"

for f in "$ZDOTDIR"/init/*
do
    . "$f"
done

if [ "$profile_startup" = yes ]
then
    unsetopt XTRACE
    exec 2>&3 3>&-
    printf '\x1b[38;5;90mProfile logged to %s\n' "$logfile"

fi
