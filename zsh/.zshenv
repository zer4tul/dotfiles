# .zshenv — 所有 zsh 启动时最先执行(交互/非交互)
# ZDOTDIR 重定向: 让 zsh 从 ~/.zsh/ 读 .zshrc/.zprofile, 无需 ~/.zshrc
export ZDOTDIR="$HOME/.zsh"

# Debian/Ubuntu 的 /etc/zsh/zshrc 会无条件全量 compinit(~0.4s), 且在插件 fpath
# 加入前执行, 迫使用户级 compinit 二次全量初始化。zsh 官方开关跳过它(macOS 上无此项, 无副作用)
skip_global_compinit=1

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
