# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Customize dir
ZSH_CUSTOM=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# theme specific settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv vcs status)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S %d/%m/%Y}"
POWERLEVEL9K_NODE_VERSION_BACKGROUND='022'
POWERLEVEL9K_OS_ICON_BACKGROUND="253"
POWERLEVEL9K_OS_ICON_FOREGROUND="234"

# `git hub colors`
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='106'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='167'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='236'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='214'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='236'

# status colors
POWERLEVEL9K_STATUS_OK_BACKGROUND="106"
POWERLEVEL9K_STATUS_OK_FOREGROUND="236"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="167"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="236"

# dir colors
POWERLEVEL9K_DIR_HOME_BACKGROUND="4"
POWERLEVEL9K_DIR_HOME_FOREGROUND="232"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="4"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="232"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="109"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="232"

# virtualenv colors
POWERLEVEL9K_VIRTUALENV_BACKGROUND="235"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="106"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="vim"

# Locale settings
export LANG="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx brew git gitextra pass autojump zsh-syntax-highlighting virtualenv virtualenvwrapper)

# for virtualenv
export WORKON_HOME=~/.virtualenv

# Set Editor and Visual
export EDITOR="vim"
#export VISUAL="gvim"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export GOPATH=~/go
export PATH=$HOME/bin:$HOME/bin/logins:$HOME/.local/bin:$HOME/utils:/usr/local/sbin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:$GOPATH/bin:$PATH
export PYTHONPATH="$PYTHONPATH:."

#export TERM=xterm-256color

# 定义颜色 {{{
if [[ ("$TERM" = *256color || "$TERM" = screen*) && -f $HOME/.lscolor256 ]]; then
    #use prefefined colors
    eval $(dircolors -b $HOME/.dir_colors)
    use_256color=1
    export TERMCAP=${TERMCAP/Co\#8/Co\#256}
    autoload spectrum.zsh
else
    [[ -f $HOME/.lscolor ]] && eval $(dircolors -b $HOME/.lscolor)
fi
#}}}

#force rehash when command not found
#  http://zshwiki.org/home/examples/compsys/general
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we did not really complete anything
}

# Enhancement for MacOS only
if [ "`uname`" = "Darwin" ]
then
    # Enhance completion for iTerm2
    compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
    alias run='open -a'
    # autojump settings
    [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

fi

# {{{ colorize commands
#show 256 color tab
256tab() {
    for k in `seq 0 1`;do 
        for j in `seq $((16+k*18)) 36 $((196+k*18))`;do 
            for i in `seq $j $((j+17))`; do 
                printf "\e[01;$1;38;5;%sm%4s" $i $i;
            done;echo;
        done;
    done
}

TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

recolor-cmd() {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
        ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
        ((end_pos=$start_pos+${#arg}))
        if $colorize; then
            colorize=false
            res=$(LC_ALL=C builtin type $arg 2>/dev/null)
            case $res in
                *'reserved word'*)   style="fg=magenta,bold";;
                *'alias for'*)       style="fg=cyan,bold";;
                *'shell builtin'*)   style="fg=yellow,bold";;
                *'shell function'*)  style='fg=green,bold';;
                *"$arg is"*)
                    [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                *)                   style='none,bold';;
            esac
            region_highlight+=("$start_pos $end_pos $style")
        fi
        [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
        start_pos=$end_pos
    done
}

check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char
# }}}

# homebrew settings
# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Util functions
hex_gbk(){
    python -c "from binascii import hexlify; print('\t'.join([\"$1\", hexlify(\"$1\".decode('utf-8').encode('gbk'))]))"
}

hex_utf8(){
    python -c "from binascii import hexlify; print('\t'.join([\"$1\", hexlify(\"$1\")]))"
}

export NVM_DIR="/Users/zer4tul/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
