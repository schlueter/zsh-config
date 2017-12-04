if which rbenv >/dev/null
then
	eval "$(rbenv init -)"
else
	printf 'rbenv not available, ignoring...\n'
fi
