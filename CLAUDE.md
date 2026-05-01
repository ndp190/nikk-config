# CLAUDE.md

This repository is the chezmoi source of truth for dotfiles and local
configuration.

## Working Rules

- Treat `dotfiles/` as the chezmoi source root. `.chezmoiroot` points there.
- Change repo source files first, then run `chezmoi --source="$PWD" apply`.
- Do not edit generated files under `$HOME` when a matching chezmoi source
  exists here.
- Keep repo-side symlink targets such as `nvim/`, `codex/`, and
  `custom-script/`; chezmoi points home-directory files at those paths.

## Common Commands

```bash
chezmoi --source="$PWD" apply
chezmoi --source="$PWD" diff
chezmoi --source="$PWD" apply ~/.zshrc
```

## Source Map

- `dotfiles/dot_zshrc` -> `~/.zshrc`
- `dotfiles/dot_tmux.conf` -> `~/.tmux.conf`
- `dotfiles/dot_gitconfig` -> `~/.gitconfig`
- `dotfiles/dot_taskrc` -> `~/.taskrc`
- `dotfiles/private_dot_claude/` -> `~/.claude/`
- `dotfiles/private_dot_codex/symlink_config.toml.tmpl` -> `~/.codex/config.toml`
- `dotfiles/dot_config/symlink_nvim.tmpl` -> `~/.config/nvim`
- `dotfiles/private_dot_tmuxifier/layouts/` -> `~/.tmuxifier/layouts/`

## Package And Bootstrap Sources

- `dotfiles/run_once_install-packages.sh.tmpl` installs Homebrew, apt, mise,
  Node, and Python packages.
- `dotfiles/run_once_before_install-shell-plugins.sh` installs TPM, Oh My Zsh,
  and zsh-autosuggestions.
- `dotfiles/run_onchange_install-custom-scripts.sh.tmpl` installs repo scripts
  into `~/.local/bin` and creates remaining app-specific symlinks.

## Neovim

Neovim is kept as a repo-side directory at `nvim/` and exposed through
`dotfiles/dot_config/symlink_nvim.tmpl`. Plugin specs live in
`nvim/lua/plugins/`; add package dependencies to
`dotfiles/run_once_install-packages.sh.tmpl`.

## Notes

- Tmux plugins still need manual installation from inside tmux with
  `<prefix> I`.
- Midnight Commander configuration is kept in `mc/` and is not currently
  applied by chezmoi.
