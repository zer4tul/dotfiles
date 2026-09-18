# dotfiles AGENTS.md

Personal dotfiles, managed with GNU Stow. Each top-level directory is a Stow package symlinked into `~`. Install: `./install.sh` (or `stow -v stow shells zsh tmux ghostty bat ls_color mycli mpv`).

## Directory Map

| Directory | Purpose |
|---|---|
| `stow/` | Stow infrastructure |
| `shells/` | Shell-agnostic config shared by zsh AND fish: `.aliases` (vi→nvim, eza, bat, duf), `.functions`, `.environment` (proxy 7890, LS_COLORS, API keys), `.config/starship.toml`, `.config/fish/` |
| `zsh/` | Zsh config (see "Zsh Architecture" below) |
| `tmux/` | Tmux (TPM, prefix C-a, `~/.tmux.conf.local` for local overrides) |
| `ghostty/` | Ghostty terminal themes (gruvbox variants) |
| `bat/` | bat config (gruvbox-dark theme) |
| `ls_color/` | vivid LS_COLORS scheme files |
| `mycli/` | MySQL client config |
| `mpv/` | Media player config |
| `macos/` | macOS system tweaks, brew/font package lists |
| `bin/` | Utility scripts (`bin/bin/macos`) |

## Zsh Architecture (ZDOTDIR mode, 2026-09)

Design goals: fast startup (~100ms), fish usability, dotfiles-managed, installer-tolerant (B mode: installer junk loads, but never touches tracked config).

### Startup chain

```
~/.zshenv          symlink → zsh/.zshenv        ONLY zsh file in $HOME.
                                                export ZDOTDIR=$HOME/.zsh → zsh reads
                                                everything else from ~/.zsh/;
                                                brew shellenv + cargo + python PATH;
                                                typeset -U path (PATH dedup for nested shells)
~/.zsh/.zshrc      symlink → zsh/.zsh/.zshrc    MAIN config (zsh reads it via ZDOTDIR,
                                                NOT via ~/.zshrc): antidote load, compinit
                                                (24h cache), history (SHARE_HISTORY),
                                                keybindings, aliases, global aliases,
                                                zoxide/starship init, PATH exports;
                                                LAST line: installer junk-drawer source
~/.zsh/.zsh_plugins.txt  symlink → antidote plugin list
~/.zsh/local.zsh   REAL FILE, NOT tracked       machine-private (keys, local PATH) —
                                                sourced by .zshrc; gitignored
~/.zsh/.zcompdump  generated                    gitignored
~/.zshrc           OPTIONAL junk drawer         NOT read by zsh itself; sourced at the
                                                end of ~/.zsh/.zshrc if present (B mode).
                                                Installers (conda/bun/rust) append here.
                                                Wipe anytime: rm ~/.zshrc
```

Why no template/entry file: ZDOTDIR is zsh's official mechanism (`~/.zshenv` is the only file always read from `$HOME`; setting `ZDOTDIR` there relocates `.zshrc`/`.zprofile`/`.zlogin`). This eliminates the thin-entry `~/.zshrc` template entirely.

### B mode (installer tolerance) — chosen over strict mode

Installers blindly append to `~/.zshrc`. Strict setups ignore that file and force manual review; we chose compatibility: the last line of `~/.zsh/.zshrc` does `[[ -r "$HOME/.zshrc" ]] && source "$HOME/.zshrc"`. Trade-off: installer lines take effect unreviewed; mitigation: the file is disposable and untracked — when in doubt `rm ~/.zshrc` and re-run the tool's init.

### Stow notes (important)

- `install.sh` runs `mkdir -p ~/.zsh` BEFORE stowing. Without this, stow symlinks the whole `dotfiles/zsh/.zsh` directory into `~/.zsh`, and generated files (`.zcompdump`, `.zsh_history`) plus machine-private `local.zsh` would land inside the git repo.
- `.zshenv` stows normally to `~/.zshenv` (top level).
- Manual symlink repair (stow normally handles it): `ln -sfn ../dotfiles/zsh/.zsh/.zshrc ~/.zsh/.zshrc` — target must be relative to `~/.zsh/`.

### Plugin management: antidote

- Plugin list: `~/.zsh/.zsh_plugins.txt`, one plugin per line
- Current plugins: `zsh-users/zsh-completions` (`kind:fpath path:src`), `zsh-autosuggestions`, `zsh-syntax-highlighting` (must stay LAST)
- `antidote load` sources static `~/.zsh/.zsh_plugins.zsh` — zero clone/network at startup; re-clones only when the list is newer
- Add/remove: edit `.zsh_plugins.txt`, restart shell (first clone needs proxy: run `proxy`)
- Update: `antidote update`
- Plugins live in `~/.antidote/` (not in dotfiles)

### fish-parity features (do not regress)

- `cd` is zoxide (`zoxide init zsh --cmd cd`): fuzzy jump, matches fish
- aliases: `ls`→eza --icons, `vi`→nvim, `cat`→bat, `df`→duf, `top`→btop, `sqlite`→litecli, `bup`
- global aliases (`alias -g`): `@cf @zrc @zenv @reddit @twitter @ins @jeeves` — expand on space, like fish abbr `--position anywhere`
- Default proxy ON via `.environment` (port 7890); `proxy`/`noproxy` functions
- starship prompt (shared config with fish), SHARE_HISTORY

### External dependencies (brew)

`antidote zoxide eza bat duf btop starship fzf` + `zsh` itself; `litecli` in `~/.local/bin`.

New-machine restore: `brew install antidote zoxide eza bat duf btop starship` → clone dotfiles → `./install.sh` → start shell (antidote auto-clones plugins; set proxy first if needed).

### Removed on purpose (do not re-add)

antigen (archived, was the 514ms bottleneck), powerlevel10k + `.p10k.zsh` (replaced by starship), oh-my-zsh (2019 leftover), thefuck (~150ms python eval), rupa/z + autojump (superseded by zoxide), ssh-agent/pass/tmux/magic-enter/zsh-autoenv OMZ bundles, thin-entry `~/.zshrc` template (superseded by ZDOTDIR).

### Known quirks

- `shells/.config/fish/config.fish` may carry a local uncommitted diff (user's own proxy tweak) — do not commit or revert without asking
- Performance regression check: `/usr/bin/time zsh -i -c exit` should stay < 150ms; if it degrades, first suspect new `eval`s in `~/.zsh/.zshrc` or a stale `.zcompdump`
- Health check after installing new tools: `ls ~/.zshrc ~/.zprofile 2>/dev/null` — anything listed is installer junk in the B-mode drawer
