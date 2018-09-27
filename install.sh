#! /bin/bash

set -x

function log_error() {
    echo $1
    exit 1
}

CURRENT_DIR=$(pwd)

if [ ! $(which git) ]; then
    install_package git
fi

DOTFILES_LOCATION=~/.config/ggarcia24_dotfiles
if [ ! -d $DOTFILES_LOCATION ]; then
    mkdir -p $DOTFILES_LOCATION
    git clone https://github.com/ggarcia24/dotfiles $DOTFILES_LOCATION
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
ln -sf "$DOTFILES_LOCATION/Git/.gitignore" .gitignore_global

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

cat <<EOF > ~/.bash_profile
source ~/.bashrc

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

EOF

if [ $(which brew) ]; then
    cat <<EOF >> ~/.bash_profile
# Add brew sbin to path!
export PATH="/usr/local/sbin:\$PATH"

EOF
fi

if [ $(which composer) ]; then
    cat <<EOF >> ~/.bash_profile
# Add composer
export PATH=~/.composer/vendor/bin:\$PATH

EOF
fi

if [ $(which rbenv) ]; then
    cat <<EOF >> ~/.bash_profile
# Add .rbenv
export PATH=~/.rbenv/shims:\$PATH

eval "\$(rbenv init -)"
EOF
fi

cd $CURRENT_DIR
