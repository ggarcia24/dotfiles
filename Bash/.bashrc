# Alwys make sure that ~/bin is on path
export PATH=$HOME/bin:$PATH

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="$HOME/ggarcia24_dotfiles/External/bash-it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='modern'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

THEME_SHOW_PYTHON=true
# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
export BASH_IT_RELOAD_LEGACY=1

# Make sure VIM is always my editor
export EDITOR='nvim'

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

# Start the SSH Agent at the login
start-ssh-agent() {
    sshfile=~/.ssh-agent-environment
    #
    if [ -n "$SSH_AUTH_SOCK" ]; then
      ssh-add -l &>/dev/null
      [[ $? != 2 ]] && unset sshfile && return 0
    fi
    #
    if [ -e "$sshfile" ]; then
      . $sshfile &>/dev/null
      ssh-add -l &>/dev/null
      [[ $? != 2 ]] && unset sshfile && return 0
    fi
    #
    ssh-agent -s > $sshfile && . $sshfile &>/dev/null
    unset sshfile
}
start-ssh-agent

# added by travis gem
[ -f "$HOME"/.travis/travis.sh ] && source "$HOME"/.travis/travis.sh

# Load Bash It
[ -f "$BASH_IT"/bash_it.sh ] && source "$BASH_IT"/bash_it.sh

# Load PyENV:
[ command -v pyenv 1>/dev/null 2>&1 ] eval "$(pyenv init -)"

# Docker Machine
[ command -v docker-machine 1>/dev/null 2>&1 ] && eval "$(docker-machine env default)"

# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if test -f ".nvmrc"; then
    nvm use
fi
. "$HOME/.cargo/env"
