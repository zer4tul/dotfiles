# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set MacOS specific PATHs
if [ "`uname`" = "Darwin" ]; then
    # Brew
    PATH="/usr/local/sbin:/usr/local/bin:$PATH"

    # for GNU Coreutils
    if [ -d "/usr/local/opt/coreutils/libexec/" ]; then
        PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    fi

    # for pip install --user
    if [ -d "$HOME/Library/Python/" ]; then
        for i in "$HOME"/Library/Python/*; do
            PATH="$i/bin/:$PATH"
        done
    fi

fi

# for gem user installation
if [ -d "$HOME/.gem/ruby/2.0.0/bin" ]; then
    PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"
fi

# nodejs
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# Golang
GOPATH=~/go
if [ -d "$GOPATH/bin" ]; then
    PATH="$PATH:$GOPATH/bin"
fi

# Python
PYTHONPATH="$PYTHONPATH:."

# rust
if [ -f "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH
export GOPATH
export PYTHONPATH
export MANPATH

# Read local settings if .profile.local exists.
if [ -f $HOME/.profile.local ]; then
    source $HOME/.profile.local
fi

