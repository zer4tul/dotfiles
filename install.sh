#!/usr/bin/env bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# color macros
if [ -t 1 ]
then
    COL_RESET="$( printf "\e[0m" )"
    COL_BLACK="$( printf "\e[30;1m" )"
    COL_RED="$( printf "\e[31;1m" )"
    COL_GREEN="$( printf "\e[32;1m" )"
    COL_YELLOW="$( printf "\e[33;1m" )"
    COL_BLUE="$( printf "\e[34;1m" )"
    COL_PURPLE="$( printf "\e[35;1m" )"
    COL_CYAN="$( printf "\e[36;1m" )"
    COL_WHITE="$( printf "\e[37;1m" )"

    COL_BG_BLACK="$( printf "\e[40m" )"
    COL_BG_RED="$( printf "\e[41m" )"
    COL_BG_GREEN="$( printf "\e[42m" )"
    COL_BG_YELLOW="$( printf "\e[43m" )"
    COL_BG_BLUE="$( printf "\e[44m" )"
    COL_BG_PURPLE="$( printf "\e[45m" )"
    COL_BG_CYAN="$( printf "\e[46m" )"
    COL_BG_WHITE="$( printf "\e[47m" )"
fi

DEFAULT_PKG="stow zsh tmux"
LINUX_ONLY_PKG="git"
MACOS_ONLY_PKG="macos"

PKG_LIST=""

clear;

function test_stow() {
    stow_exec=$(which stow)
    if [ $? -ne 0 ]; then
        echo "ERROR: Please install ${COL_RED}GNU stow${COL_RESET} with your package manager first."
        exit 1
    fi
}


function test_git() {
    git_exec=$(which git)
    if [ $? -ne 0 ]; then
        echo "ERROR: Please install ${COL_RED}git${COL_RESET} with your package manager first."
        exit 1
    fi
}

function list_packages() {
    echo $(find $BASE_DIR -maxdepth 1 -mindepth 1 -type d | grep -v '.git' | awk -F / '{print $NF}')
}

function stow_dotfiles() {
    # stow
    clear
    echo "stow dotfile folders"
    $stow_exec -v $(list_packages)
}

function install_shell_global_config() {
    echo 'source "$HOME"/.profile.global' >> "$HOME"/.profile
    echo 'source "$HOME"/.zshrc.global' >> "$HOME"/.zshrc
}


function tweak_macos() {
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

test_stow
test_git
stow_dotfiles && install_shell_global_config

OS=$(uname)
if [ "$OS" = "Darwin" ]; then
    tweak_macos
fi
