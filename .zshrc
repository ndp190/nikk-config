# Profiling zsh
# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# User configuration
ZSH_DOTENV_PROMPT=false

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  composer
  dotenv
  zsh-autosuggestions
  autojump
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias dc='docker-compose -f docker-compose.yml -f docker-compose-fn.yml'
alias dc='docker-compose'
alias ll='ls -la'
alias vim="nvim"
alias vi="nvim"
alias c='clear'

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# export DOCKER_HOST=tcp://localhost:2375
export DOCKER_HOST=unix:///var/run/docker.sock
# export PATH=~/.composer/vendor/bin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# export PATH="/usr/local/opt/node@8/bin:$PATH"

# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8

# pip
#export PATH=~/Library/Python/2.7/bin:$PATH
#export PYTHONPATH=/usr/local/lib/python3.9/site-packages

export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
export PATH="/usr/local/opt/php@7.2/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"

export PATH="/Applications/flutter/bin:$PATH"
source <(kubectl completion zsh)

export VISUAL=nvim
export EDITOR=nvim

export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Load pyenv automatically by appending
# the following to ~/.zshrc:
# eval "$(pyenv init -)"
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.symfony/bin:$PATH"

# iTerm2 settings
DISABLE_AUTO_TITLE="true"
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

# utilities
function pfwd {
    ARGS=""
    for i in ${@:2}
    do
      ARGS+=" -L ${i}:localhost:${i}"
    done
    echo "ssh $1$ARGS"
    eval "ssh $1${ARGS}"
}

function pbwd {
    pgrep -af '^ssh.*ubuntu' | xargs kill
}

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source /usr/local/bin/lazy-nvm.sh

# The following lines were added by compinstall

autoload -Uz compinit
compinit
# End of lines added by compinstall


# Created by `pipx` on 2023-02-27 15:01:38
export PATH="$PATH:/Users/phuc.nguyen/.local/bin"
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

test -d "$HOME/.tea" && source <("$HOME/.tea/tea.xyz/v*/bin/tea" --magic=zsh --silent)

eval $(thefuck --alias)

# Profiling zsh
# zprof
