# Oh-my-zsh settings {{{1
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Customize dir
ZSH_CUSTOM=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ ("$TERM" = *256color || "$TERM" = screen*) ]]; then
    ZSH_THEME="powerlevel9k/powerlevel9k"
else
    ZSH_THEME="simple"
fi

## Icon settings {{{2
##POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\U2BC8'                  # ⯈
##POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\U2BC7'                 # ⯇
#POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\U276F'                   # ❯
#POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\U276E'                  # ❮
##POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\U2591'                  # ░
##POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\U2591'                 # ░
##POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\U2592'                  # ▒
##POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\U2592'                 # ▒
#POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=' '                     # Whitespace
#POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\U232A'                # 〉
#POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\U2329'               # 〈
##POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\U2E3D'               # ⸽
##POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\U2E3D'              # ⸽
##POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
##POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
#POWERLEVEL9K_CARRIAGE_RETURN_ICON=$'\U21B5'                     # ↵
#POWERLEVEL9K_ROOT_ICON=$'\U26A1'                                # ⚡
#POWERLEVEL9K_RUBY_ICON=''
#POWERLEVEL9K_AWS_ICON='AWS:'
#POWERLEVEL9K_AWS_EB_ICON=$'\U1F331 '                            # 🌱
#POWERLEVEL9K_BACKGROUND_JOBS_ICON=$'\U2699'                     # ⚙
#POWERLEVEL9K_TEST_ICON=''
#POWERLEVEL9K_TODO_ICON=$'\U2611'                                # ☑
#POWERLEVEL9K_BATTERY_ICON=$'\U1F50B'                            # 🔋
#POWERLEVEL9K_OK_ICON=$'\U2713'                                  # ✓
#POWERLEVEL9K_FAIL_ICON=$'\U2718'                                # ✘
#POWERLEVEL9K_SYMFONY_ICON='SF'
#POWERLEVEL9K_NODE_ICON=$'\U2B22'                                # ⬢
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=$'\U256D'$'\U2500'   # ╭─
#POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=$'\U2570'$'\U2500 ' # ╰─
POWERLEVEL9K_APPLE_ICON=$'MacOS'                               # 
#POWERLEVEL9K_FREEBSD_ICON=$'\U0001F608 '                        # 😈
#POWERLEVEL9K_LINUX_ICON=$'\U0001F427'                           # 🐧
#POWERLEVEL9K_SUNOS_ICON='Sun'
#POWERLEVEL9K_HOME_ICON=$'\U0001F3E0'                            # 🏠
#POWERLEVEL9K_HOME_SUB_ICON=$'\U0001F4C2'                        # 📂
#POWERLEVEL9K_FOLDER_ICON=$'\U0001F4C1'                          # 📁
#POWERLEVEL9K_NETWORK_ICON='IP'
#POWERLEVEL9K_LOAD_ICON='L'
#POWERLEVEL9K_SWAP_ICON='SWP'
#POWERLEVEL9K_RAM_ICON='RAM'
#POWERLEVEL9K_SERVER_ICON=''
#POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
#POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\U25CF'                        # ●
#POWERLEVEL9K_VCS_STAGED_ICON=$'\U271A'                          # ✚
#POWERLEVEL9K_VCS_STASH_ICON=$'\U235F'                           # ⍟
#POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\U2B8B '               # ⮋
#POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\U2B89 '               # ⮉
#POWERLEVEL9K_VCS_TAG_ICON=''
#POWERLEVEL9K_VCS_BOOKMARK_ICON=$'\U0001F516'                    # 🔖
#POWERLEVEL9K_VCS_COMMIT_ICON=$'\U29F2'                          # ⧲
#POWERLEVEL9K_VCS_BRANCH_ICON=$'\U2387 '                         # ⎇
#POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=$'\U2192'                   # →
POWERLEVEL9K_VCS_GIT_ICON=$'\U24D6'                             # ⓖ
POWERLEVEL9K_VCS_HG_ICON=$'\U24D7'                              # ⓗ
POWERLEVEL9K_VCS_SVN_ICON=$'\U24E2'                             # ⓢ
#POWERLEVEL9K_RUST_ICON=''
POWERLEVEL9K_PYTHON_ICON=$'\U1F40D'                             # 🐍


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
# }}}

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

# Plugins {{{2
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(tmux git gitextra pass autojump zsh-syntax-highlighting virtualenv)

# Plugins for MacOS only {{{3
if [ "`uname`" = "Darwin" ]
then
    # Add MacOS spicified plugin into plugin list
    plugins=($plugins osx)
fi
# }}}
# }}}

source $ZSH/oh-my-zsh.sh
# }}}

# User settings {{{1

# aliases {{{2
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="vim"
# }}}

# Locale settings {{{2
export LANG="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
# }}}


# virtualenv {{{2
if [ -x /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
    export WORKON_HOME=~/.virtualenv
fi
# }}}

# Set Editor and Visual {{{2
export EDITOR="vim"
#export VISUAL="gvim"
# }}}


#export TERM=xterm-256color

# Colors {{{2
if [[ ("$TERM" = *256color || "$TERM" = screen*) && -f $HOME/.dir_colors ]]; then
    #use prefefined colors
    eval $(dircolors -b $HOME/.dir_colors)
    use_256color=1
    export TERMCAP=${TERMCAP/Co\#8/Co\#256}
    autoload spectrum.zsh
else
    [[ -f $HOME/.lscolor ]] && eval $(dircolors -b $HOME/.lscolor)
fi
#}}}

#force rehash when command not found {{{2
#  http://zshwiki.org/home/examples/compsys/general
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we did not really complete anything
}
# }}}


# {{{ colorize commands
#show 256 color tab

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

# support colors in less {{{2
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# }}}

# Util functions {{{2
hex_gbk(){
    python -c "from binascii import hexlify; print('\t'.join([\"$1\", hexlify(\"$1\".decode('utf-8').encode('gbk'))]))"
}

hex_utf8(){
    python -c "from binascii import hexlify; print('\t'.join([\"$1\", hexlify(\"$1\")]))"
}

256tab() {
    for k in `seq 0 1`;do 
        for j in `seq $((0+k*18)) 36 $((196+k*18))`;do 
            for i in `seq $j $((j+17))`; do 
                printf "\e[01;$1;38;5;%sm%4s" $i $i;
            done;echo;
        done;
    done
}
# }}}

# Enhancement for MacOS only {{{2
if [ "`uname`" = "Darwin" ]
then
    # Enhance completion for iTerm2
    compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
    alias run='open -a'

    # autojump settings
    [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

    # homebrew settings
    # Set architecture flags
    export ARCHFLAGS="-arch x86_64"

    # use ls from GNU Coreutils ( if exists ) instead of BSD ls.
    GLS=$(which -s gls)
    if [ $? -eq 0 ]; then
        alias ls='ls --color=auto'
    fi

fi
# }}}

# }}}

# vim: ft=zsh:fdm=marker
