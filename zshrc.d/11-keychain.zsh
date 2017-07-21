GPGKEY=8C4854C3
GPG_TTY=$(tty)
export GPGKEY GPG_TTY
export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
