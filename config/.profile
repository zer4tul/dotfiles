# PATH settings

# local commands per user
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# Brew
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# for GNU Coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Golang
export GOPATH=~/go
export PATH="$PATH:$GOPATH/bin"

# Python
export PYTHONPATH="$PYTHONPATH:."

# Read local settings if .profile.local exists.
if [ -f $HOME/.profile.local ]; then
    source $HOME/.profile.local
fi
