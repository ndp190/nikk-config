# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository (nikk-config) for macOS and Linux systems. It manages configuration files for development tools including Neovim, tmux, zsh, git, and various terminal emulators. The repository uses symlinks to install configurations from this directory to the home directory.

## Installation and Setup

### Initial Setup
```bash
make              # Install all configurations (auto-detects OS)
```

The makefile auto-detects the OS and runs the appropriate installation:
- **macOS**: Installs all tools including Karabiner, Aerospace, nvim, tmux, zsh, git, WezTerm, and Taskwarrior
- **Linux**: Installs nvim, zsh, and git configurations

### Individual Component Installation
```bash
make install-nvim         # Install Neovim config only
make install-tmux         # Install tmux config only
make install-zsh          # Install zsh config only
make install-git          # Install git config only
make install-karabiner    # Install Karabiner config (macOS)
make install-aerospace    # Install Aerospace config (macOS)
make install-wezterm      # Install WezTerm config (macOS)
```

### Cleanup
```bash
make clean        # Remove all symlinked configurations
```

### Prerequisites Installation
- Homebrew packages: `./install-brew.sh` (edit this file to add/remove packages)
- Node packages: `./install-node.sh` (edit this file to add/remove packages)
- Python packages: `./install-pip.sh` (edit this file to add/remove packages)

## Architecture

### Directory Structure
```
.
├── nvim/                      # Neovim configuration (Lazy.nvim plugin manager)
│   ├── init.lua              # Entry point, loads lazy.nvim and vim_scripts
│   ├── lua/
│   │   ├── config/           # Lazy.nvim configuration
│   │   └── plugins/          # Plugin specifications
│   │       ├── code.lua      # LSP, treesitter, code formatting
│   │       ├── editor.lua    # Editor behavior, neo-tree, telescope, etc.
│   │       ├── keymap.lua    # Custom keybindings
│   │       ├── custom_actions.lua  # Custom Lua functions
│   │       ├── git.lua       # Git integration plugins
│   │       ├── infra.lua     # Infrastructure/DevOps tools
│   │       └── nikk_terminal.lua   # Terminal integration
│   └── vim_scripts/          # Legacy vim scripts loaded after Lua
├── custom-script/            # Custom shell scripts symlinked to /usr/local/bin
│   ├── autogen-pyinit.sh    # Generate __init__.py files recursively
│   ├── echo-colorized.sh    # Print colorized output
│   └── lazy-nvm.sh          # Lazy-load NVM to improve shell startup time
├── .zshrc                    # Zsh configuration with oh-my-zsh
├── .tmux.conf               # Tmux configuration with custom theme
├── .gitconfig               # Git configuration (includes conditional configs)
├── karabiner.json           # Karabiner key remapping (macOS)
├── .aerospace.toml          # Aerospace window manager config (macOS)
├── .wezterm.lua            # WezTerm terminal config (macOS)
└── makefile                 # Installation orchestration
```

### Neovim Architecture

Neovim uses **Lazy.nvim** as the plugin manager with a modular plugin configuration:

- **Plugin loading**: All files in `nvim/lua/plugins/*.lua` are automatically imported
- **LSP servers configured**: lua_ls, gopls, jsonls, bashls, terraformls, jedi_language_server (Python), intelephense (PHP), ts_ls, quick_lint_js, astro, prismals, svelte, rust_analyzer, ast_grep
- **Key features**:
  - Treesitter for syntax highlighting and code folding
  - Auto-format on save for supported filetypes
  - Tab width: 2 spaces for TypeScript/JavaScript/HTML/CSS/Ruby, 4 spaces for Python/PHP
  - Neo-tree file explorer with dotfiles visible, gitignored files hidden
  - Telescope fuzzy finder
  - Line numbers only shown in active window

### Zsh Architecture

- **Framework**: oh-my-zsh with custom theme "amuse"
- **Plugins**: git, tmux, composer, dotenv, zsh-autosuggestions
- **Performance optimization**:
  - NVM is lazy-loaded via `lazy-nvm.sh` to improve startup time
  - `compinit` is cached for 24 hours
- **Custom configurations**: Sourced from `~/.zsh_custom.zsh` (user-specific settings like GPG signing)
- **Key aliases**: `ll`, `lg` (lazygit), `v`/`vi` (nvim), `g` (git), `k` (kubectl)
- **Custom functions**:
  - `f()` - fuzzy find and open file in vim using fzf
  - `vim()` - opens current directory if no args
  - `pfwd()` - SSH port forwarding helper
  - `codeartifact()` - AWS CodeArtifact authentication

### Tmux Configuration

- **Plugin manager**: TPM (Tmux Plugin Manager)
- **Plugins**:
  - vim-tmux-navigator (seamless navigation between vim and tmux)
  - tmux-pomodoro-plus (productivity timer)
  - tmux-nowplaying (music display with scrolling)
  - tmuxifier (session templates)
- **Theme**: Custom theme with status bar at top, dual status lines showing time, date, and personal domains
- **Key bindings**:
  - Alt+H/L or Shift+Alt+Up/Down - switch windows
  - Shift+Alt+Left/Right - reorder windows
  - New windows/panes open in current directory
- **Install plugins**: Enter tmux session and press `<leader> I` (Ctrl+B then Shift+I)

### Git Configuration

- **Conditional includes**: Uses separate configs for different hosts/organizations
  - `~/.gitconfig_go1` - work-specific config (example provided)
  - `~/.gitconfig_github` - personal GitHub config (example provided)
- **Global gitignore**: `~/.gitignore_global`
- Supports GPG signing (configured in `~/.zsh_custom.zsh`)

## Custom Scripts

Available globally via symlinks in `/usr/local/bin`:

1. **autogen-pyinit**: Generate `__init__.py` files recursively in a directory
   ```bash
   autogen-pyinit <directory>
   ```

2. **echo-colorized**: Print colorized terminal output
   ```bash
   echo-colorized '[0;31mConflictError[0m:'
   ```

3. **lazy-nvm**: Lazy-load NVM on first use (sourced in .zshrc)

## Development Workflow

### Working with Neovim Config
- Plugins auto-install on first launch via Lazy.nvim
- Add new plugins by creating/editing files in `nvim/lua/plugins/`
- Plugin specs follow Lazy.nvim format
- Run `:Lazy` in Neovim to manage plugins

### Working with Shell Config
- Edit `.zshrc` for general zsh configuration
- Edit `~/.zsh_custom.zsh` for machine-specific settings (not in repo)
- Run `source ~/.zshrc` to reload after changes

### Working with Tmux Config
- Edit `.tmux.conf` for tmux configuration
- Reload tmux: `tmux source-file ~/.tmux.conf` or `<prefix>:source-file ~/.tmux.conf`
- Install new plugins: Add plugin line, then `<prefix> I` in tmux session

### Adding New Tools
1. Add package to appropriate install script (`install-brew.sh`, `install-node.sh`, or `install-pip.sh`)
2. Add configuration file to repo root
3. Add symlink command to makefile under appropriate `install-*` target
4. Run `make install-<component>` to test

## Special Notes

- **Midnight Commander**: Configuration in `/mc` folder, not included in install script
- **Kitty SSH**: When SSH'ing from Kitty terminal, use: `runkitty +kitten ssh user@host`
- **1Password SSH Agent**: Configured at `~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock`
- **Vim freeze with tmux**: Resolved by disabling software flow control (`stty -ixon`) and tmux-navigator workaround for CrowdStrike
- **CodeArtifact**: Use `codeartifact-login` then `codeartifact` functions for AWS CodeArtifact auth
