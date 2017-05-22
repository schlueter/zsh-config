GPG_TTY=$(tty)
export GPG_TTY
eval $(gpg /bye)
export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
eval $(keychain --eval --agents gpg,ssh id_ed25519 8C4854C3 --quiet)
