# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow. Each top-level directory represents a "package" that Stow symlinks into `~` (home directory).

## Installation and Stowing

The repository uses GNU Stow for symlinking dotfiles into the home directory:

```bash
# Install all dotfiles (run from repo root)
stow -v stow shells zsh tmux ghostty bat ls_color mycli mpv

# Or use the provided install script
./install.sh
```

On macOS, the install script will optionally run `bin/bin/macos` to apply system-level tweaks.

## Directory Structure and Purpose

### Shell Configurations

- **shells/** - Shared shell configurations used by both zsh and fish
  - `.aliases` - Command aliases (vi→nvim, ls→eza, cat→bat, df→duf)
  - `.functions` - Custom shell functions (hex_gbk, hex_utf8, brew_fresh)
  - `.environment` - Environment variables (includes proxy settings on port 7890)
  - `.config/fish/` - Fish shell configs (config.fish, fish_plugins for Fisher)
  - `.config/starship.toml` - Starship prompt configuration

- **zsh/** - Zsh-specific configurations
  - `.zshrc` - Main zsh config using Antigen plugin manager
  - `.zshrc_macos` - macOS-specific zsh settings (Homebrew paths, architecture detection)
  - `.zshrc.global` - Global/legacy zsh settings with Powerlevel10k theme
  - `.zsh/themes/powerlevel10k` - Git submodule for Powerlevel10k theme

### Terminal and Shell Tools

- **fish/** - Fish shell (via shells/.config/fish/)
  - Uses Fisher plugin manager (`fish_plugins`)
  - Starship prompt integration
  - zoxide for smart cd navigation
  - Proxy toggle functions: `proxy` and `noproxy`

- **tmux/** - Tmux terminal multiplexer
  - `.tmux.conf` - Uses TPM plugin manager
  - Vim-like keybindings (prefix: C-a)
  - External themes supported via `~/.tmux/themes/`
  - Local overrides via `~/.tmux.conf.local`

- **ghostty/** - Ghostty terminal emulator
  - `.config/ghostty/themes/` - Custom color themes (gruvbox variants)

### CLI Tools

- **bat/** - Modern `cat` replacement with syntax highlighting
  - `.config/bat/config` - Uses gruvbox-dark theme

- **ls_color/** - LS color configurations
  - `.config/vivid/` - Vivid color scheme files (gruvbox-dark.yml, filetypes.yml)

- **mycli/** - MySQL CLI client
  - `.myclirc` - MySQL client configuration

### Other Configurations

- **mpv/** - Media player
  - `.config/mpv/` - Contains mpv.conf, input.conf, lua-settings, scripts

- **macos/** - macOS-specific configurations
  - System settings, Homebrew package lists, font lists, Quicklook plugins

- **bin/** - Utility scripts
  - `bin/bin/macos` - macOS system tweak script

## Key Tools and Managers

### Plugin Managers
- **Antigen** (zsh) - Bundles: zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting, z, git, git-extras
- **Fisher** (fish) - Plugin manager for Fish shell
- **TPM** (tmux) - Plugin manager for tmux

### Modern CLI Replacements
- `bat` instead of `cat`
- `eza` instead of `ls`
- `duf` instead of `df`
- `zoxide` for smart cd navigation
- `starship` for cross-shell prompt

### Proxy Configuration
The environment is configured to use a local proxy on port 7890. Shell functions `proxy` and `noproxy` toggle this setting.

### macOS-Specific
- Homebrew integration with `brew_fresh()` function
- Autojump for directory navigation
- System tweaks via `bin/bin/macos`

## Stow Package Structure

Each top-level directory (e.g., `shells/`, `zsh/`, `tmux/`) is a Stow package. The structure mirrors the target location in `~`:

```
shells/
├── .aliases          → ~/.aliases
├── .functions        → ~/.functions
├── .environment      → ~/.environment
└── .config/fish/     → ~/.config/fish/
```

To add new dotfiles, create a new top-level directory or add to an existing one, keeping the directory structure matching the desired location in `~`.
