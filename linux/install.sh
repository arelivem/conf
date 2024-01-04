#!/bin/bash


# confirm wget installed
if ! which wget &> /dev/null; then
    echo "wget is not installed, please try again after installed."
    exit 1
fi


# config bashrc
OS=$(uname -s)
GIT_STORE='store'
if [ "${OS}" == 'Linux' ]; then
    [ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.back
    cp -f ./.bashrc ~/.bashrc
elif [ "${OS}" == 'Darwin' ]; then
    [ -f ~/.bash_profile ] && mv ~/.bash_profile ~/.bash_profile.back
    cp -f ./.bashrc ~/.bash_profile
    GIT_STORE='osxkeychain'
else
    echo "OS: ${OS} not support."
    exit 1
fi
[ ! -d ~/.Trash ] && mkdir ~/.Trash
[ ! -d ~/.bin ] && mkdir ~/.bin


# config inputrc (hot keys)
[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.back
cp -f ./.inputrc ~/.inputrc


# config vim
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimr.back
cp -f ./.vimrc ~/.vimrc
[ ! -f ~/.history ] && touch ~/.history


# config git
if which git &> /dev/null; then
    git config --global init.defaultBranch main
    git config --global core.autocrlf true
    git config --global credential.helper ${GIT_STORE}  # config credential type
    git config --global credential.useHttpPath true  # config match git path
else
    echo "git is not installed."
fi


# config tmux
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.back
cp -f ./.tmux.conf ~/.tmux.conf


echo "============================================================="
echo "Install finished."
echo ""
echo "Please re-login for the settings to take effect."
echo "============================================================="
