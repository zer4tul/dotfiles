if status is-interactive
    # Commands to run in interactive sessions can go here

        # Start starship
    starship init fish | source

    # Set abbrs
    abbr -a ls "eza --icons --group-directories-first"
    abbr -a vi "nvim"
    abbr -a cat "bat"
    abbr -a df "duf"

    if type -q btm
        abbr --add top btm
    else if type -q btop
        abbr --add top btop
    else if type -q htop
        abbr --add top htop
    end

    abbr --add sqlite "litecli"

    if test (uname) = "Darwin"
        abbr --add bup "brew update && brew upgrade --greedy && brew cleanup"
    end

    # Setting file name abbrivations
    abbr --add --position anywhere @cf "$HOME/.config/fish/config.fish"
    abbr --add --position anywhere @reddit "$HOME/Downloads/gallery_dl/reddit"
    abbr --add --position anywhere @twitter "$HOME/Downloads/gallery_dl/twitter"
    abbr --add --position anywhere @ins "$HOME/Downloads/gallery_dl/instagram"
    abbr --add --position anywhere @jeeves "$HOME/go/src/github.com/zer4tul/jeeves"

    # 代理开关函数
    function proxy
      set -gx http_proxy "http://127.0.0.1:7890"
      set -gx https_proxy "http://127.0.0.1:7890"
      set -gx all_proxy "socks5://127.0.0.1:7890"
      echo "Proxy: ON 🚀"
    end

    function noproxy
      set -e http_proxy
      set -e https_proxy
      set -e all_proxy
      echo "Proxy: OFF 🚫"
    end

    # 默认开启代理
    proxy
end

zoxide init --cmd cd fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# OpenClaw Completion
source "/Users/kefei/.openclaw/completions/openclaw.fish"
