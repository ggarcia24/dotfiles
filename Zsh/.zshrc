export fpath=( ~/.zfunc "${fpath[@]}" )

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

setopt promptsubst

export TERM="xterm-256color"

# Download antigen if it doesn't exists
if [ ! -f  ~/antigen.zsh ]; then
    curl -L git.io/antigen > ~/antigen.zsh
fi
source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# jenv options
export JENV_SHELL=zsh
export JENV_LOADED=1
unset JAVA_HOME
unset JDK_HOME

# NVM options
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim')

# pyenv options
ZSH_PYENV_QUIET=true

# Load plugins
antigen bundles <<EOBUNDLES
    # Bundles from the default repo (robbyrussell's oh-my-zsh)
    safe-paste
    brew
    git
    npm
    osx
    kubectl
    pipenv
    pyenv
    jenv
    # tmux
    z

    lukechilds/zsh-nvm

    # Syntax highlighting bundle.
    zsh-users/zsh-syntax-highlighting

    zsh-users/zsh-completions

    zsh-users/zsh-autosuggestions

    darvid/zsh-poetry
EOBUNDLES


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
BULLETTRAIN_VIRTUALENV_BG=magenta
BULLETTRAIN_NVM_BG=yellow
BULLETTRAIN_NVM_FG=black
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=red

BULLETTRAIN_PROMPT_ORDER=(
    dir
    status
    ruby
    virtualenv
    nvm
    git
    custom
    screen
    aws
    cmd_exec_time
  )

ZSH_THEME="bullet-train"

# Tell Antigen that you're done.
antigen apply

setopt AUTO_CD            # Change to a directory just by typing its name
setopt AUTO_PUSHD         # Make cd push each old directory onto the stack
setopt CDABLE_VARS        # Like AUTO_CD, but for named directories
setopt PUSHD_IGNORE_DUPS  # Don't push duplicates onto the stack

unsetopt LIST_BEEP        # Don't beep on an ambiguous completion

# History environment variables
HISTFILE=${HOME}/.zsh_history
HISTSIZE=120000  # Larger than $SAVEHIST for HIST_EXPIRE_DUPS_FIRST to work
SAVEHIST=100000

setopt EXTENDED_HISTORY       # Save time stamps and durations
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first
setopt HIST_IGNORE_DUPS     # Do not enter 2 consecutive duplicates into history
setopt HIST_IGNORE_SPACE    # Ignore command lines with leading spaces
setopt HIST_VERIFY          # Reload results of history expansion before executing
setopt INC_APPEND_HISTORY   # Constantly update $HISTFILE
setopt SHARE_HISTORY        # Constantly share history between shell instances

setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode

alias l='ls -al'
alias curl='curl --silent --show-error'
alias tf='terraform'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
# alias vim='nvim'

# global aliases
alias -g L='| less'
alias -g G='| grep'


eval "$(direnv hook zsh)"


jenv rehash 2>/dev/null
jenv refresh-plugins
jenv() {
  type typeset &> /dev/null && typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}

export GRAPHVIZ_DOT=$(which dot)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Gonzalo.Garcia/Projects/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/Gonzalo.Garcia/Projects/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Gonzalo.Garcia/Projects/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/Gonzalo.Garcia/Projects/google-cloud-sdk/completion.zsh.inc'; fi
gcloud components update
