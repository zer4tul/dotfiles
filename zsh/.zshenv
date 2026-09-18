# .zshenv — 所有 zsh 启动时最先执行(交互/非交互), 用于关键 PATH 初始化
# brew shellenv 必须在这里: 非交互 zsh 不跑 .zshrc, 但 brew 子命令依赖此 PATH

# Homebrew (必须最早: 后续 PATH 依赖 brew 的 bin)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Cargo
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Python 3 (Homebrew formula)
export PATH="/opt/homebrew/opt/curl/bin:${PATH}"
[[ -d "$HOME/Library/Python/3.11/bin" ]] && export PATH="$HOME/Library/Python/3.11/bin:${PATH}"
