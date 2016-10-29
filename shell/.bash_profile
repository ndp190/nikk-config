alias ll='ls -lG'
alias SQLyog='wine "C:/Program Files/SQLyog/SQLyog.exe" &'
alias SQLyogCommunity='wine "C:/Program Files/SQLyog Community/SQLyogCommunity.exe" &'
alias sf='php app/console'

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export PATH="$(brew --prefix josegonzalez/php/php55)/bin:$PATH"
#export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/nikk/Documents/cocos2d-x-3.9/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Users/nikk/Documents/cocos2d-x-3.9/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# cocos2dx
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=$PATH:/usr/local/sbin

# export rabbitmq
export PATH=$PATH:/usr/local/Cellar/rabbitmq/3.6.1/sbin

# export composer global path
export PATH=~/.composer/vendor/bin:$PATH

# export GO1 env vars
export SYMFONY_ENV="dev"

# golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# added by Anaconda3 4.1.1 installer
export PATH="/Users/nikk/anaconda/bin:$PATH"
