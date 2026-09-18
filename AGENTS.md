# dotfiles AGENTS.md

Personal dotfiles, managed with GNU Stow. Each top-level directory is a Stow package symlinked into `~`. Install: `./install.sh`.

## Directory Map

| Directory | Purpose |
|---|---|
| `stow/` | Stow infrastructure |
| `shells/` | Shared by zsh AND fish: `.aliases`, `.functions`, `.environment` (proxy 7890, LS_COLORS), `.config/starship.toml`, `.config/fish/` |
| `zsh/` | Zsh config (`.zshenv`, `.zsh/.zshrc`, `.zsh/.zsh_plugins.txt`) |
| `tmux/` | Tmux (TPM, prefix C-a) |
| `ghostty/` `bat/` `ls_color/` `mycli/` `mpv/` | App configs |
| `macos/` `bin/` | macOS tweaks, utility scripts |

## Zsh

### Environment

```
~/.zshenv                 → zsh/.zshenv          ONLY zsh file in $HOME: ZDOTDIR=$HOME/.zsh,
                                                  brew shellenv, cargo, python PATH, typeset -U
~/.zsh/.zshrc             → zsh/.zsh/.zshrc      MAIN config (zsh reads it via ZDOTDIR):
                                                  plugins, completion, history, aliases,
                                                  zoxide, starship, PATH
~/.zsh/.zsh_plugins.txt   → zsh/.zsh/.zsh_plugins.txt   antidote plugin list
~/.zsh/local.zsh          machine-private, NOT tracked, gitignored
~/.zshrc                  installer junk drawer (conda/bun append here); not read by
                          zsh itself; sourced at the END of ~/.zsh/.zshrc if present
                          and may be deleted by the user at any time
```

Dependencies (brew): `antidote zoxide eza bat duf btop starship fzf` (+ `zsh`); `litecli` in `~/.local/bin`.

### Rules

1. **Zsh config changes go in `dotfiles/zsh/` files, never in `~/.zshrc`** — that file is installer-managed and disposable.
2. **PATH/env needed by all zsh (incl. non-interactive)** → `zsh/.zshenv`. **Interactive config** → `zsh/.zsh/.zshrc`. **Machine-specific or secret values** → `~/.zsh/local.zsh` (untracked).
3. **Aliases/functions shared with fish** → `shells/.aliases` / `.functions` / `.environment`; only zsh-specific behavior in `.zshrc`.
4. **Plugins**: edit `zsh/.zsh/.zsh_plugins.txt`, one per line; `zsh-syntax-highlighting` must stay LAST. First clone needs network — run `proxy` first. Update: `antidote update`.
5. **Do not add**: antigen, oh-my-zsh, powerlevel10k, thefuck, autojump, rupa/z (zoxide covers it), or any plugin manager other than antidote.
6. **Do not regress fish-parity**: `cd`=zoxide fuzzy jump; aliases ls→eza/vi→nvim/cat→bat/df→duf/top→btop/sqlite→litecli; global aliases `@cf @zrc @zenv @reddit @twitter @ins @jeeves`; default proxy on 7890 with `proxy`/`noproxy`; starship; SHARE_HISTORY.
7. **Commit discipline**: never commit `~/.zshrc` junk, `.zcompdump*`, `local.zsh` (gitignored); never commit or revert the user's local diff in `shells/.config/fish/config.fish` without asking.
8. **Stow**: `~/.zsh` must exist as a real directory BEFORE stowing (install.sh does `mkdir -p ~/.zsh`), otherwise stow symlinks the whole `dotfiles/zsh/.zsh` dir and generated/private files land inside the repo. Manual symlink repair under `~/.zsh/` uses relative targets: `../dotfiles/...`.

### Verify after any zsh change

```
zsh -i -c 'echo $+functions[_zsh_highlight] $(whence -w cd)'   # expect "1 cd: function" (brew zoxide ≥1.0) or "1 cd: alias" (apt zoxide 0.9: --cmd cd 用 alias 实现, 行为等价, 可接受)
/usr/bin/time zsh -i -c exit                                    # expect < 150ms
```

If startup degrades: suspect new `eval`s in `.zshrc` or a stale `.zsh/.zcompdump` (safe to delete).

## New-machine restore

`brew install antidote zoxide eza bat duf btop starship` → clone this repo → `./install.sh` → new shell (antidote auto-clones plugins; `proxy` first if network blocked).
