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
)

source $ZSH/oh-my-zsh.sh

source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

# additional config
source ~/.zsh_custom.zsh

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
alias ll='ls -la'
alias lg='lazygit'
alias v=vim
alias vi=vim
alias g='git'
alias k='kubectl'
alias k-qa='kubectl --context=k8s-qa'
alias k-prod='kubectl --context=k8s-prod'
alias k-3s='kubectl --context=k3s'

function f () {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always {} | head -100')
  if [[ -n "$file" ]]; then
    vim "$file"
  fi
}

wtfutil() {
  local JIRA_API_KEY
  local JIRA_USER_ID

  JIRA_API_KEY=$(op item get "JIRA API key wtfutil" --field "token" --reveal)
  JIRA_USER_ID=$(op item get "JIRA API key wtfutil" --field "nikk_assignee_id" --reveal)

  export JIRA_API_KEY JIRA_USER_ID

  command wtfutil --config=<(envsubst < ~/nikk-config/wtfutil-config.yml)
}

# alias vim, make 'vim' = 'vim .'
vim() {
    if [ $# -eq 0 ]; then
        command nvim .
    else
        command nvim "$@"
    fi
}

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export VISUAL=nvim
export EDITOR=nvim

# Disable software flow control (ctrl-s/ctrl-q) to hopefully fix vim freezing when using with tmux
stty -ixon

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

source /usr/local/bin/lazy-nvm.sh

# The following lines were added by compinstall

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
# End of lines added by compinstall


# zoxide (better 'cd')
eval "$(zoxide init zsh)"

codeartifact() {
    CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain go1 --domain-owner 654654359634 --region us-east-1 --query authorizationToken --profile codeartifact --output text`
    if [ -z "$CODEARTIFACT_AUTH_TOKEN" ]; then
        echo "Failed to get CodeArtifact token"
        return 1
    else
        echo "CodeArtifact token set"
        export CODEARTIFACT_AUTH_TOKEN=${CODEARTIFACT_AUTH_TOKEN}
    fi
}

codeartifact-login() {
    aws sso login --profile codeartifact
}
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

claudeOp() {
    export CLAUDE_CODE_GH_PAT=$(echo '{{op://Private/PAT claude code mcp/token}}' | op inject)
    command claude "$@"
}

opencodeOp() {
    export CLAUDE_CODE_GH_PAT=$(echo '{{op://Private/PAT claude code mcp/token}}' | op inject)
    command opencode "$@"
}

# Profiling zsh !!ALWAYS AT THE END
# zprof
