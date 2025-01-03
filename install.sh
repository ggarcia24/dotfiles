#! /bin/bash

set -x

DOTFILES_LOCATION="$HOME"/ggarcia24_dotfiles

CURRENT_DIR=$(pwd)

OS=
case "$(uname -s)" in
    Darwin)
        OS='MacOS'
        ;;
    Linux)
        OS='Linux'
        ;;
    CYGWIN*|MINGW32*|MSYS*)
        OS='Windows'
        ;;
esac

function install_package() {
    if [ $OS == 'MacOS' ]; then
        # If brew isn't there install it
        if ! [ -x "$(command -v brew)" ]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # After install add homebrew to the path
            eval "$(/opt/homebrew/bin/brew shellenv)"

        fi
        brew install $1
        exit_code=$?
    elif [ $OS == 'Linux' ]; then
        INSTALL_COMMAND=
        if [ -x "$(command -v apt)" ]; then
            INSTALL_COMMAND=apt
        elif [ -x "$(command -v apt-get)" ]; then
            INSTALL_COMMAND=apt-get
        elif [ -x "$(command -v yum)" ]; then
            INSTALL_COMMAND=yum
        fi
        sudo $INSTALL_COMMAND install $1
        exit_code=$?
    elif [ $OS == 'Windows' ]; then
        log_error "Windows not supported"
    fi
    # exit $exit_code
}

function log_error() {
    echo $1
    exit 1
}

if [ ! $(command -v brew) ]; then
    install_package git
fi

if [ ! -d $DOTFILES_LOCATION ]; then
    mkdir -p $DOTFILES_LOCATION
    git clone --recursive https://github.com/ggarcia24/dotfiles $DOTFILES_LOCATION
fi

if [ ! -d $DOTFILES_LOCATION/.git ]; then
    log_error "'$DOTFILES_LOCATION' directory exists bit is not a git repository"
else
    cd $DOTFILES_LOCATION
    git pull
fi

# After all the cloning has been done, simlink all the things!
cd $HOME
ln -sf "$DOTFILES_LOCATION/Bash/.bashrc"
ln -sf "$DOTFILES_LOCATION/Bash/aliases.sh" .aliases
ln -sf "$DOTFILES_LOCATION/Bash/functions.sh" .functions

if [ ! -f ~/.gitconfig ]; then
    touch ~/.gitconfig
fi
cat <<EOF >> ~/.gitconfig

[include]
	path = ~/ggarcia24_dotfiles/Git/.gitconfig

EOF

ln -sf "$DOTFILES_LOCATION/Git/.gitignore" .gitignore_global
ln -sf "$DOTFILES_LOCATION/Zsh/.zshrc"

if [ ! -d ~/.ssh ]; then
    ln -sf "$DOTFILES_LOCATION/SSH" .ssh
fi

if [ ! -d ~/.vim ]; then
    ln -sf "$DOTFILES_LOCATION/VIM/.vim" .vim
fi
ln -sf "$DOTFILES_LOCATION/VIM/.vimrc" .vimrc
ln -sf "$DOTFILES_LOCATION/VIM/.ideavimrc" .ideavimrc

if [ ! -d ~/bin ]; then
    ln -sf "$DOTFILES_LOCATION/Scripts" bin
fi

if [ $(command -v conky) ]; then
    ln -sf "$DOTFILES_LOCATION/Conky" .conky
    ln -sf "$DOTFILES_LOCATION/Conky/.conkyrc" .conkyrc
fi

cat <<EOF > ~/.bash_profile
if [ -f "$HOME"/.bashrc ]; then
    source $HOME/.bashrc
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

EOF

if [ $(command -v brew) ]; then
    cat <<EOF >> ~/.bash_profile
# Add brew sbin to path!
export PATH="/usr/local/sbin:\$PATH"

EOF
fi

if [ $(command -v composer) ]; then
    cat <<EOF >> ~/.bash_profile
# Add composer
export PATH=~/.composer/vendor/bin:\$PATH

EOF
fi

if [ $(command -v rbenv) ]; then
    cat <<EOF >> ~/.bash_profile
# Add .rbenv
export PATH=~/.rbenv/shims:\$PATH

eval "\$(rbenv init -)"
EOF
fi

# If there's mapping configure it here
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}]}'

cd $CURRENT_DIR

if [ ! $(command -v nvim) ]; then 
    install_package neovim
fi

if [ ! $(command -v tux) ]; then 
    install_package tmux
fi

if [ ! $(command -v pyenv) ]; then 
    install_package pyenv
fi

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash


echo "If you are on a Linux remember to execute $DOTFILES_LOCATION/Linux.sh"
echo "If you are on a Mac remember to execute $DOTFILES_LOCATION/MacOS.sh"
