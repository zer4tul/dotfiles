# ~/.zshrc — 快速启动 + fish 易用性。备份: ~/.zshrc.bak.20260918
# 架构: 无插件管理器, 插件静态 clone 在 ~/.zsh/plugins/

if [[ -o interactive ]]; then
  # macOS (brew shellenv)
  [[ ! -f "$HOME/.zshrc_macos" ]] || source "$HOME/.zshrc_macos"

  # --- 补全框架: 先补全插件进 fpath, 再 compinit ---
  fpath=("$HOME/.zsh/plugins/zsh-users/zsh-completions/src" $fpath)
  source "$HOME/.zsh/plugins/zsh-users/zsh-completions/zsh-completions.plugin.zsh" 2>/dev/null
  source "$HOME/.zsh/plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"

  autoload -Uz compinit
  # .zcompdump 24h 内复用缓存(-C 跳过安全检查), 过期才全量重建
  if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi

  # --- history: fish 风格实时共享 ---
  HISTFILE="$HOME/.zsh_history"
  HISTSIZE=50000
  SAVEHIST=50000
  setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_SPACE
  setopt AUTO_CD INTERACTIVE_COMMENTS

  # --- 键绑定: emacs 风格 + 修正 home/end/delete/词跳转 ---
  bindkey -e
  bindkey '\e[1;5C' forward-word    # ctrl+→
  bindkey '\e[1;5D' backward-word
  bindkey '\e[3~'   delete-char
  bindkey '\e[1;3C' forward-word    # option+→
  bindkey '\e[1;3D' backward-word

  # --- aliases / functions / environment (dotfiles 共享) ---
  source "$HOME/.aliases"
  source "$HOME/.functions"
  source "$HOME/.environment"

  # --- 对齐 fish abbr ---
  alias ls='eza --icons --group-directories-first'
  alias top='btop'
  alias sqlite='litecli'
  alias bup='brew update && brew upgrade --greedy && brew cleanup'

  # 全局缩写 (输入后按空格展开, 等价 fish abbr --position anywhere)
  alias -g @cf="$HOME/.config/fish/config.fish"
  alias -g @zrc="$HOME/.zshrc"
  alias -g @reddit="$HOME/Downloads/gallery_dl/reddit"
  alias -g @twitter="$HOME/Downloads/gallery_dl/twitter"
  alias -g @ins="$HOME/Downloads/gallery_dl/instagram"
  alias -g @jeeves="$HOME/go/src/github.com/zer4tul/jeeves"

  # --- zoxide 接管 cd (与 fish 一致: cd foo 模糊跳转) ---
  eval "$(zoxide init zsh --cmd cd)"

  # --- 提示符: starship (配置沿用 ~/.config/starship.toml) ---
  eval "$(starship init zsh)"

  # --- 语法高亮必须最后加载 ---
  source "$HOME/.zsh/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

  # --- 本机私有配置 ---
  [[ -f "$HOME/.zsh/local.zsh" ]] && source "$HOME/.zsh/local.zsh"

  # --- 从 fish 同步的环境变量 ---
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  export PATH="$HOME/.comate/bin:$PATH"
  export PATH="$HOME/.comate/baidu-cc/bin:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export SANDBOX_USERNAME=kefei
