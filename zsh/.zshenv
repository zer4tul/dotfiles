# .zshenv — 所有 zsh 启动时最先执行(交互/非交互)
# ZDOTDIR 重定向: 让 zsh 从 ~/.zsh/ 读 .zshrc/.zprofile, 无需 ~/.zshrc
export ZDOTDIR="$HOME/.zsh"

# PATH 去重: .zshenv 每个 zsh 都跑(含嵌套 shell), 不去重 PATH 会无限堆积
typeset -U path PATH

# Homebrew (必须最早: 后续 PATH 依赖 brew 的 bin)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Cargo
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Python 3 (Homebrew formula)
export PATH="/opt/homebrew/opt/curl/bin:${PATH}"
[[ -d "$HOME/Library/Python/3.11/bin" ]] && export PATH="$HOME/Library/Python/3.11/bin:${PATH}"
