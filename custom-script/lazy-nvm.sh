# invoke nvm only once you run your first node (or npm, npx, or nvm) command
# purpose: improve zsh startup time
function lazy_nvm {
  unset -f nvm
  unset -f npm
  unset -f node
  unset -f npx

  if [ -d "${HOME}/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # linux
    [ -s "$(brew --prefix nvm)/nvm.sh" ] && source $(brew --prefix nvm)/nvm.sh # osx
    [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && source $(brew --prefix nvm)/etc/bash_completion.d/nvm # osx
  fi
}

# aliases
function nvm { lazy_nvm; nvm "$@"; }
function npm { lazy_nvm; npm "$@"; }
function node { lazy_nvm; node "$@"; }
function npx { lazy_nvm; npx "$@"; }
