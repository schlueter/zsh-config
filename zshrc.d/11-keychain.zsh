GPGKEY=8C4854C3
GPG_TTY=$(tty)
export GPGKEY GPG_TTY
export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
eval $(keychain --eval --agents gpg,ssh id_ed25519 8C4854C3 --quiet)