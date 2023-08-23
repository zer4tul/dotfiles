# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

os=$(uname)
if [ "$os" = "Darwin" ]
then
    # Add MacOS spicified plugin into plugin list
    [[ ! -f "$HOME/.zshrc_macos" ]] || source "$HOME/.zshrc_macos"
fi

# Add Antigen Bundles
antigen bundles <<EOBUNDLES
command-not-found
colored-man-pages
magic-enter
ssh-agent
extract
tmux
git
git-extras
pass
autojump

Tarrasch/zsh-autoenv

zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting

rupa/z
EOBUNDLES

antigen theme romkatv/powerlevel10k
# antigen theme denysdovhan/spaceship-prompt

antigen apply # Use it

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

# Aliases
source "$HOME/.aliases"

# Useful functions
source "$HOME/.functions"

# Environment variables
source "$HOME/.environment"

if [ -e "$HOME/.zsh/local.zsh" ]; then # If local.zsh exists, source it
  source ~/.zsh/local.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
