# dotfiles AGENTS.md

Personal dotfiles, managed with GNU Stow. Each top-level directory is a Stow package symlinked into `~`. Install: `stow -v stow shells zsh tmux ghostty bat ls_color mycli mpv` or `./install.sh`.

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

## Zsh Architecture (2026-09 fish→zsh migration)

Design goals: **fast startup (~90ms)**, keep fish usability, dotfiles-managed, installer-proof.

### Startup chain (what loads, in order)

```
~/.zshenv          symlink → zsh/.zshenv        brew shellenv + cargo + python PATH
                                             (runs for ALL zsh incl. non-interactive;
                                              brew must resolve here or nothing works)
~/.zshrc           REAL FILE, 2 lines only      thin entry; source ~/.zshrc-global
                                                (kept as real file so installers
                                                 (conda/bun/etc.) can append to it
                                                 without touching main config)
                                                ⚠ do NOT stow-symlink this file —
                                                 see "~/.zshrc must be a real file" below
~/.zshrc-global    symlink → zsh/.zshrc-global  MAIN config: antidote load, compinit
                                                (24h cache), history (SHARE_HISTORY),
                                                keybindings, aliases, global aliases,
                                                zoxide/starship init, PATH exports
~/.zshrc_macos     symlink → zsh/.zshrc_macos   mac-only extension slot (currently empty)
~/.zsh/local.zsh   REAL FILE, NOT in dotfiles   machine-private (keys, local PATH)
```

### ~/.zshrc must be a real file — how to set it up

Why: installers (conda, bun, rust, opencode…) append to `~/.zshrc`. If it were a symlink into the repo, every such append would dirty the tracked template with machine-specific junk. Keeping it real + 2 lines makes it disposable: delete and regenerate anytime.

Concrete method (already automated in `install.sh`):

1. **Stow with ignore** — stow must NOT link `.zshrc`:
   `stow -v zsh --ignore='^\.zshrc$'` (install.sh passes this flag; do not drop it)
2. **Copy the template** instead of linking:
   `cp ~/dotfiles/zsh/.zshrc ~/.zshrc`
3. **Verify**: `test ! -L ~/.zshrc && echo real-file-ok`
4. **Reset** when polluted: `rm ~/.zshrc && cp ~/dotfiles/zsh/.zshrc ~/.zshrc` — the template is just `source ~/.zshrc-global`.

Gotcha: running plain `stow zsh` (no `--ignore`) on a machine where `~/.zshrc` already exists as a real file will fail with a conflict — that's the guard working; use the flag.

### Plugin management: antidote

- Plugin list: `~/.zsh_plugins.txt` (symlink → `zsh/.zsh_plugins.txt`), one plugin per line
- Current plugins: `zsh-users/zsh-completions` (`kind:fpath path:src`), `zsh-autosuggestions`, `zsh-syntax-highlighting` (must stay LAST)
- `antidote load` sources the static file `~/.zsh_plugins.zsh` — zero clone, zero network at startup; it re-clones only when `.zsh_plugins.txt` is newer
- Add/remove: edit `.zsh_plugins.txt`, restart shell (first clone needs proxy: run `proxy`)
- Update: `antidote update`
- Plugins live in `~/.antidote/` (not in dotfiles)

### fish-parity features (do not regress)

- `cd` is zoxide (`zoxide init zsh --cmd cd`): fuzzy jump, matches fish
- aliases: `ls`→eza --icons, `vi`→nvim, `cat`→bat, `df`→duf, `top`→btop, `sqlite`→litecli, `bup`
- global aliases (`alias -g`): `@cf @zrc @zglob @reddit @twitter @ins @jeeves` — expand on space, like fish abbr `--position anywhere`
- Default proxy ON via `.environment` (port 7890); `proxy`/`noproxy` functions
- starship prompt (shared config with fish), SHARE_HISTORY

### External dependencies (brew)

`antidote zoxide eza bat duf btop starship fzf` + `zsh` itself; `litecli` in `~/.local/bin`. Restore on a new machine: `brew install antidote zoxide eza bat duf btop starship`, stow, copy `zsh/.zshrc` template to `~/.zshrc`, start a shell (antidote auto-clones plugins).

### Removed on purpose (do not re-add)

antigen (archived, was the 514ms bottleneck), powerlevel10k + `.p10k.zsh` (replaced by starship), oh-my-zsh (2019 leftover), thefuck (~150ms python eval), rupa/z + autojump (superseded by zoxide), ssh-agent/pass/tmux/magic-enter/zsh-autoenv OMZ bundles.

### Known quirks

- `shells/.config/fish/config.fish` may carry a local uncommitted diff (user's own proxy tweak) — do not commit or revert without asking
- Performance regression check: `/usr/bin/time zsh -i -c exit` should stay < 150ms; if it degrades, first suspect new `eval`s in `.zshrc-global` or a stale `.zcompdump`
