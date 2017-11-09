if which pyenv >/dev/null
then
	eval "$(pyenv init -)"
else
	printf 'pyenv not available, ignoring...\n'
fi
