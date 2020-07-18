#!/bin/sh

GIT_USER_EMAIL="mintobit@gmail.com"
GIT_USER_NAME="Anton Nizhegorodov"

sudo apt-get update
sudo apt-get install -qq git vim zsh wget ncdu htop php

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -f ~/.ssh/id_rsa -N ''
fi

chsh -s $(grep /zsh$ /etc/shells | tail -1)
if [ ! -d ~/.oh-my-zsh ]; then
    echo 'Setting up oh-my-zsh...'
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
    echo 'oh-my-zsh is already installed'
fi

ACTUAL_GIT_USER_EMAIL="$(git config --global --get user.email)"
if [ -z $ACTUAL_GIT_USER_EMAIL ]; then
    echo 'Setting up git user.email...'
    git config --global user.email $GIT_USER_EMAIL
fi

ACTUAL_GIT_USER_NAME="$(git config --global --get user.name)"
if [ -z $ACTUAL_GIT_USER_NAME ]; then
    echo 'Setting up git user.name...'
    git config --global user.name $GIT_USER_NAME
fi

if [ ! -f /usr/local/bin/composer ]; then
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        >&2 echo 'Composer insallation error: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    RESULT=$?
    rm composer-setup.php
    if [ $RESULT -eq 0 ]; then
        sudo mv composer.phar /usr/local/bin/composer
    else
        >&2 echo "Composer installation error: Installer exit code `$RESULT`"
    fi
fi

echo 'Overriding .gitconfig...'
cp gitconfig ~/.gitconfig
echo 'Overriding .zshrc...'
cp zshrc ~/.zshrc
echo 'Overriding .vimrc...'
cp vimrc ~/.vimrc

echo 'Logout and log back in to make zsh your default shell'
