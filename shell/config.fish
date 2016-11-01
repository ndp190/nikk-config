set -g -x PATH /usr/local/bin $PATH
set -g -x fish_greeting ''

# homebrew sbin
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# export composer global path
set -gx PATH ~/.composer/vendor/bin $PATH

# export npm path
set -gx PATH ~/.npm-packages/bin $PATH

# export rabbitmq
set -gx PATH /usr/local/Cellar/rabbitmq/3.6.1/sbin $PATH

# export golang
set GOPATH /usr/local/Cellar/go/1.7.3/libexec
set PATH $GOPATH/bin $PATH

alias SQLyog 'wine "C:/Program Files/SQLyog/SQLyog.exe"'
alias SQLyogCommunity 'wine "C:/Program Files/SQLyog Community/SQLyogCommunity.exe"'
alias sf 'php app/console'
alias sock 'ssh -D 127.0.0.1:8990 -fNg aegir@139.162.25.32'

# Bang bang
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end
