# Alwys make sure that ~/bin is on path
export PATH=$PATH:~/bin

# Change terminal to resemble the Linux 
export PS1="\u@\h:\w\$ "

# Make sure VIM is always my editor
export EDITOR='vim'

# Locales
export LC_ALL=en_US.UTF-8

# History!
SHELL_SESSION_HISTORY=0
HISTFILESIZE=50000
HISTSIZE=1000

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

## VIRTUALENVWRAPPER ##
export WORKON_HOME=~/Envs
export PROJECT_HOME=~/Projects
source /usr/local/bin/virtualenvwrapper.sh

## ALIASES ##
alias mux="tmuxinator"

# Purpose: avoid killing containers
function docker-stats() {
    docker stats
}
# Purpose: reset docker environment 
# Argument (optional): all 
#
# "docker-reset" will stop and remove all containers (except dinghy_http_proxy) and custom networks
#
# "docker-reset all" will reset the docker environment to clean slate (you will lose *all* volumes and custom networks!)
#
# Note: you'll need to install docker-clean: brew install docker-clean
function docker-reset() {
  run_all=$1

  if [[ "${run_all}" == "all" ]]; then
    docker-kill-all
    echo "Running docker-clean ..."
    docker-clean
  else
    docker-stop-all
    echo "Running docker-clean --networks ..."
    docker-clean --networks
  fi
}

# Purpose: Kill and remove all docker containers (except for dinghy_http_proxy)
function docker-kill-all() {
  PROXY=$(docker ps | grep dinghy_http_proxy | awk '{print $1}')
  echo "Killing docker containers..."
  docker kill $(docker ps -q | grep -v $PROXY) &> /dev/null
  echo "Removing docker containers..."
  docker rm $(docker ps -a --filter "status=exited" -q) &> /dev/null
}

# Purpose: Stop and remove all docker containers (except for dinghy_http_proxy)
function docker-stop-all() {
  PROXY=$(docker ps | grep dinghy_http_proxy | awk '{print $1}')
  echo "Stopping docker containers..."
  docker stop $(docker ps -q | grep -v $PROXY) &> /dev/null
  echo "Removing docker containers..."
  docker rm $(docker ps -a --filter "status=exited" -q) &> /dev/null
}

# Purpose: Delete all images related to the provided tag name
# Example: `docker-nuke selenium` will delete all images whose tags contain the word "selenium"
function docker-nuke() {
  args=("$@")
  docker ps -a | grep ${args[0]} | cut -d ' ' -f 1 | while read ID; do docker rm $ID; done;
  docker images | grep ${args[0]} | tr -s " " | cut -d ' ' -f 3 | while read ID; do docker rmi $ID; done
}

# Purpose: Remove all images
function docker-rmi-all() {
  docker rmi -f $(docker images -q)
}

# Purpose: slap virtualbox
# Example: Using virtualbox as the VM for dinghy's docker host sometimes causes image download
# latency. Run this function in a separate shell window when that happens.
function slap-virtualbox() {
  while true; do dinghy ssh echo "turbo mode activated"; done
}


# added by travis gem
[ -f /Users/ggarcia/.travis/travis.sh ] && source /Users/ggarcia/.travis/travis.sh
