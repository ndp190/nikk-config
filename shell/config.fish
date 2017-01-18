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
set -x GOPATH /Users/nikk/Projects/giy
set -x GOROOT /usr/local/Cellar/go/1.7.3/libexec
set PATH $GOROOT/bin $PATH
set PATH $GOPATH/bin $PATH

#set JAVA_HOME

## export hadoop
#set HADOOP_INSTALL /usr/local/Cellar/hadoop/2.7.3
#set HADOOP_PREFIX /usr/local/Cellar/hadoop/2.7.3
#set HADOOP_HOME /usr/local/Cellar/hadoop/2.7.3
#set HADOOP_MAPRED_HOME $HADOOP_INSTALL
#set HADOOP_COMMON_HOME $HADOOP_INSTALL
#set HADOOP_HDFS_HOME $HADOOP_INSTALL
#set YARN_HOME $HADOOP_INSTALL
#set HADOOP_CONFDIR $HADOOP_HOME/etc/hadoop
#set HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_INSTALL/lib/native
#set PATH $PATH $HADOOP_INSTALL/sbin
#set PATH $PATH $HADOOP_INSTALL/libexec
#set PATH $PATH $HADOOP_INSTALL/bin
#set CLASSPATH $CLASSPATH .
#set CLASSPATH $CLASSPATH $HADOOP_INSTALL/libexec/share/hadoop/common/hadoop-common-2.7.3.jar
#set CLASSPATH $CLASSPATH $HADOOP_INSTALL/libexec/share/hadoop/common/hadoop-nfs-2.7.3.jar
#set CLASSPATH $CLASSPATH $HADOOP_INSTALL/libexec/share/hadoop/common/lib
# 
## export sqoop
#set SQOOP_HOME /usr/local/sqoop
#set PATH $PATH $SQOOP_HOME/bin

alias SQLyog 'wine "C:/Program Files/SQLyog/SQLyog.exe"'
alias SQLyogCommunity 'wine "C:/Program Files/SQLyog Community/SQLyogCommunity.exe"'
alias sf 'php app/console'
alias sock 'ssh -D 127.0.0.1:8990 -fNg aegir@139.162.25.32'
# hadoop
alias hstart '/usr/local/Cellar/hadoop/2.7.3/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/2.7.3/sbin/start-yarn.sh'
#alias hstart '/usr/local/Cellar/hadoop/2.7.3/sbin/start-yarn.sh;/usr/local/Cellar/hadoop/2.7.3/sbin/start-dfs.sh'
alias hstop '/usr/local/Cellar/hadoop/2.7.3/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/2.7.3/sbin/stop-dfs.sh'

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

#if [ -x /usr/libexec/java_home ]; then
#    set JAVA_HOME $(/usr/libexec/java_home)
#else
#    set JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
#fi
#set JAVA_HOME (/usr/libexec/java_home)
set JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
set HADOOP_CLASSPATH {$JAVA_HOME}/lib/tools.jar

# direnv
eval (direnv hook fish)

set VAGRANT_HOME /Volumes/Nikk\ Passport/.vagrant.d/
