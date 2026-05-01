# Nikk config

This repository is a chezmoi source tree for dotfiles and local development
configuration. The chezmoi source root is `dotfiles/`, configured by
`.chezmoiroot`.

## Apply

```bash
chezmoi --source="$PWD" apply
```

For a single target:

```bash
chezmoi --source="$PWD" apply ~/.zshrc
```

## Layout

- `dotfiles/` contains chezmoi-managed source files.
- `nvim/`, `codex/`, and selected repo directories are symlink targets used by
  chezmoi source files.
- `custom-script/` contains scripts linked into `~/.local/bin` by
  `dotfiles/run_onchange_install-custom-scripts.sh.tmpl`.

## Editing

Make changes in the repo source first, then run `chezmoi apply`. Do not edit a
generated home-directory file directly when the corresponding source exists in
this repo.

Common source paths:

- `dotfiles/dot_zshrc` -> `~/.zshrc`
- `dotfiles/dot_tmux.conf` -> `~/.tmux.conf`
- `dotfiles/dot_gitconfig` -> `~/.gitconfig`
- `dotfiles/private_dot_claude/` -> `~/.claude/`
- `dotfiles/private_dot_codex/symlink_config.toml.tmpl` -> `~/.codex/config.toml`
- `dotfiles/dot_config/symlink_nvim.tmpl` -> `~/.config/nvim`

## Packages

Package setup lives in `dotfiles/run_once_install-packages.sh.tmpl`. Shell
plugin bootstrap lives in `dotfiles/run_once_before_install-shell-plugins.sh`.

## Notes

- Tmux plugins still need to be installed from inside tmux with `<prefix> I`.
- Midnight Commander configuration is kept in `mc/` and is not currently
  applied by chezmoi.
