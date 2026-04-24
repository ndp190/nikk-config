# Repository Instructions

This repository is the chezmoi source of truth for the user's dotfiles and local configuration.

Rules for changes in this repo:

- Treat files under this repository as chezmoi-managed source files, not as live home-directory config targets.
- Make changes in the repo source paths here first, then apply them with `chezmoi apply` when deployment is needed.
- Do not edit files directly under `$HOME` when the corresponding chezmoi source exists in this repository.
- When adding new managed config, prefer the correct chezmoi source naming and path conventions so the generated target path is unambiguous.
- If behavior depends on generated or symlinked files in `$HOME`, verify the repo source and the deployed target both match before debugging runtime issues.
