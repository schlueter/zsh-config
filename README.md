# Schlueter's zsh configuration

My zsh configuration using zprezto.

## Installation

Clone this repo and its submodules somewhere:

    git clone --recursive https://github.com/schlueter/zsh-config $XDG_CONFIG_HOME/zsh

Then set your **ZDOTDIR** to that location somewhere that will be picked up when the
shell is started. I do this in my [kitty][] [config][my kitty config], but doing so
in **$HOME/.zshenv** should also work:

    ZDOTDIR="$XDG_CONFIG_HOME/zsh"

## Development

A Dockerfile is included for development. To use, build it from the root of the
repository with:

    docker build --tag zsh:latest .

Then run with:

    docker run -it zsh

To test changes without rebuilding the image you may run with the local directory
mounted as the zsh configuration within the container:

    docker run -v $PWD:/home/testuser/.config/zsh -it zsh

[kitty]: https://sw.kovidgoyal.net/kitty/
[my kitty config]: https://github.com/schlueter/misc/blob/3886d9936399b0fe55cad362c17ea1ca0c37de15/files/XDG_CONFIG_HOME/kitty/kitty.conf
