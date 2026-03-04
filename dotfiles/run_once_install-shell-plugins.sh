#!/bin/bash
set -e

# === TPM (Tmux Plugin Manager) ===
if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
    echo "[chezmoi] Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "[chezmoi] TPM already installed"
fi

# === Oh My Zsh ===
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    echo "[chezmoi] Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "[chezmoi] Oh My Zsh already installed"
fi

# === zsh-autosuggestions ===
if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "[chezmoi] Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "[chezmoi] zsh-autosuggestions already installed"
fi
