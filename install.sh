#!/usr/bin/env bash

DEFAULT_PKG="stow zsh tmux"
LINUX_ONLY_PKG="git"
MACOS_ONLY_PKG="macos"

PKG_LIST=""

clear;

test_stow() {
    stow_exec=$(which stow)
    if [ $? -eq 0 ]; then
        echo "ERROR: Please install GNU stow with your package manager first."
        exit 1
    fi
}

default() {
    # stow
    clear
    echo "2. stow dotfile folders"
    $stow_exec emacs git profile sqlite zshrc

    # zsh
    echo "3. set zsh as default shell"
    chsh -s /bin/zsh
}


tweak_macos() {
    QUESTION="Tweak MacOS settings?(Y/n)"
    echo -e $QUESTION

    while true
    do
        # -n return after 1 char
        # -s don't echo user input
        read -n 1 -s ANSWER

        case $ANSWER in
            [yY] )
                SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
                bash "$SCRIPTPATH/bin/macos"
                break;;
            [nN] )
                clear;
                echo "abort"
                exit;;
            * )
                clear
                echo -e "Input Error\n"$QUESTION;;
        esac
    done
}

OS=$(uname)
if [ "$OS" = "Darwin" ]; then
    PKG_LIST="$DEFAULT_PKG $MACOS_ONLY_PKG"
    tweak_macos
elif [ "$OS" = "Linux" ]; then
    PKG_LIST="$DEFAULT_PKG $LINUX_ONLY_PKG"
fi
