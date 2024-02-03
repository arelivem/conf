#!/bin/bash


function check_command() {
    local cmd=$1
    if ! which ${cmd} &> /dev/null; then
        echo "${cmd} is not found!"
        exit 1
    fi
}


function check_os() {
    echo 'checking OS ...'

    OS=$(uname -s)
    if [[ "${OS}" != 'Linux' ]] && [[ "${OS}" != 'Darwin' ]]; then
        echo "OS: ${OS} not support."
        exit 1
    fi
}


function bash_config() {
    echo 'configuring bash ...'

    echo -n 'setup login shell [/bin/bash] (Y/n): '
    read confirm
    [[ "${confirm}" == 'Y' ]] && check_command /bin/bash && chsh -s /bin/bash

    [[ -f ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc.back
    cp -f ./.bashrc ~/

    if [[ "${OS}" == 'Darwin' ]]; then
        [[ -f ~/.bash_profile ]] && mv ~/.bash_profile ~/.bash_profile.back
        cp -f ./.bash_profile ~/
    fi

    # config inputrc (hot keys)
    [[ -f ~/.inputrc ]] && mv ~/.inputrc ~/.inputrc.back
    cp -f ./.inputrc ~/

    [[ ! -d ~/.Trash ]] && mkdir ~/.Trash
    [[ ! -d ~/.bin ]] && mkdir ~/.bin
}


function zsh_config() {
    echo 'configuring zsh ...'

    echo -n 'setup login shell [/bin/zsh] (Y/n): '
    read confirm
    [[ "${confirm}" == 'Y' ]] && check_command /bin/zsh && chsh -s /bin/zsh

    [[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.back
    cp -f ./.zshrc ~/

    if [[ "${OS}" == 'Darwin' ]]; then
        [[ -f ~/.zprofile ]] && mv ~/.zprofile ~/.zprofile.back
        cp -f ./.zprofile ~/
    fi

    [[ ! -d ~/.Trash ]] && mkdir ~/.Trash
    [[ ! -d ~/.bin ]] && mkdir ~/.bin
}


function vim_config() {
    echo 'configuring vim ...'

    [[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.back
    cp -f ./.vimrc ~/

    echo -n 'add syntax highlighting (Y/n): '
    read confirm
    [[ "${confirm}" == 'Y' ]] && vim_syntax
}


function vim_syntax() {
    echo 'adding vim syntax highlighting ...'

    [[ ! -d ~/.vim ]] && mkdir ~/.vim

    check_command git
    git clone https://github.com/vim/vim.git

    cp ./vim/runtime/filetype.vim ~/.vim/

    [[ ! -d ~/.vim/ftplugin ]] && mkdir ~/.vim/ftplugin
    cp ./vim/runtime/ftplugin/*.vim ~/.vim/ftplugin/

    [[ ! -d ~/.vim/syntax ]] && mkdir ~/.vim/syntax
    cp ./vim/runtime/syntax/*.vim ~/.vim/syntax/

    /bin/rm -rf ./vim
}


function git_config() {
    echo 'configuring git ...'

    check_command git

    local GIT_STORE='store'
    if [[ "${OS}" == 'Darwin' ]]; then
        GIT_STORE='osxkeychain'
    fi

    git config --global init.defaultBranch main
    git config --global core.autocrlf input   # true for Windows
    git config --global credential.helper ${GIT_STORE}  # config credential type
    git config --global credential.useHttpPath true  # config match git path
}


function tmux_config() {
    echo 'configuring tmux ...'

    [[ -f ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf.back
    cp -f ./.tmux.conf ~/
}


function proxy_config() {
    echo 'configuring proxy ...'

    [[ -f ~/.cmd_proxy ]] && mv ~/.cmd_proxy ~/.cmd_proxy.back
    cp -f ./.cmd_proxy ~/
}


function menu() {
    echo ''
    echo '=================================================='
    echo 'Choose Settings: '
    echo '    1) bash'
    echo '    2) zsh'
    echo '    3) vim'
    echo '    4) git'
    echo '    5) tmux'
    echo '    6) proxy'
    echo '    q/Q) quit.'
    echo -n 'Enter number (eg:2 3 4 5): '
}


function main() {
    while true; do
        menu
        read response
        if [[ -z "${response}" ]]; then
            continue
        elif [[ "${response}" == "q" ]] || [[ "${response}" == "Q" ]]; then
            break
        else
            response=(${response})
            for index in "${response[@]}"; do
                case "${index}" in
                    1) bash_config
                        ;;
                    2) zsh_config
                        ;;
                    3) vim_config
                        ;;
                    4) git_config
                        ;;
                    5) tmux_config
                        ;;
                    6) proxy_config
                        ;;
                    *) echo "${index} is invalid value."
                        ;;
                esac
            done
        fi
    done
}


echo '=================================================='
echo 'Setup Development Configuration'
check_os
main
echo ''
echo '=================================================='
echo 'Setup finished.'
echo ''
echo 'Please re-login for the settings to take effect.'
echo '=================================================='
