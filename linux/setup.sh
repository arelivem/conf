#!/usr/bin/env bash


OS=$(uname -s)


function check_os() {
    echo 'checking OS ...'

    if [[ "${OS}" != 'Linux' ]] && [[ "${OS}" != 'Darwin' ]]; then
        echo "OS: ${OS} not support."
        exit 1
    fi
}


function check_command() {
    local cmd=$1
    if ! which ${cmd} &> /dev/null; then
        echo "${cmd} is not found!"
        return 1
    fi
    return 0
}


function alias_config() {
    [[ -f ~/.alias ]] && mv ~/.alias ~/.alias.back
    if [[ "${OS}" == 'Linux' ]]; then
        cp -f ./.alias_linux ~/.alias
    elif [[ "${OS}" == 'Darwin' ]]; then
        cp -f ./.alias_mac ~/.alias
    else
        echo "OS: ${OS} not support."
    fi
}


function directory_config() {
    [[ ! -d ~/.Trash ]] && mkdir ~/.Trash
    [[ ! -d ~/.bin ]] && mkdir ~/.bin
}


function bash_config() {
    echo 'configuring bash ...'

    local bash_path=$(which bash)
    echo "bash path: ${bash_path}"

    echo -n "setup login shell [${bash_path}] (Y/n): "
    read confirm
    [[ "${confirm}" == 'Y' ]] && chsh -s ${bash_path}

    [[ -f ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc.back
    cp -f ./.bashrc ~/

    [[ -f ~/.bash_profile ]] && mv ~/.bash_profile ~/.bash_profile.back
    cp -f ./.bash_profile ~/

    # config inputrc (hot keys)
    [[ -f ~/.inputrc ]] && mv ~/.inputrc ~/.inputrc.back
    cp -f ./.inputrc ~/

    alias_config
    directory_config
}


function zsh_config() {
    echo 'configuring zsh ...'

    local zsh_path=$(which zsh)
    echo "zsh path: ${zsh_path}"

    echo -n "setup login shell [${zsh_path}] (Y/n): "
    read confirm
    [[ "${confirm}" == 'Y' ]]  && chsh -s ${zsh_path}

    [[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.back
    cp -f ./.zshrc ~/

    [[ -f ~/.zprofile ]] && mv ~/.zprofile ~/.zprofile.back
    cp -f ./.zprofile ~/

    alias_config
    directory_config
}


function vim_config() {
    echo 'configuring vim ...'

    [[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.back
    cp -f ./.vimrc ~/

    # echo -n 'add vim syntax highlighting (Y/n): '
    # read confirm
    # [[ "${confirm}" == 'Y' ]] && vim_syntax
}


function vim_syntax() {
    echo 'adding vim syntax highlighting ...'

    [[ ! -d ~/.vim ]] && mkdir ~/.vim

    check_command git
    git clone https://github.com/vim/vim.git

    cp -f ./vim/runtime/filetype.vim ~/.vim/

    [[ ! -d ~/.vim/ftplugin ]] && mkdir ~/.vim/ftplugin
    cp -f ./vim/runtime/ftplugin/*.vim ~/.vim/ftplugin/

    [[ ! -d ~/.vim/syntax ]] && mkdir ~/.vim/syntax
    cp -f ./vim/runtime/syntax/*.vim ~/.vim/syntax/

    /bin/rm -rf ./vim
}


function git_config() {
    echo 'configuring git ...'

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

    if [[ ! -f ~/.alias ]]; then
        echo "failed. please init bash/zsh first."
        return 1
    fi

    local tmux_path=$(which tmux)
    echo "tmux path: ${tmux_path}"

    bash alias_tmux.sh

    [[ -f ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf.back
    cp -f ./.tmux.conf ~/

}


function proxy_config() {
    echo 'configuring proxy ...'

    if [[ ! -f ~/.alias ]]; then
        echo "failed. please init bash/zsh first."
        return 1
    fi

    cat proxy_cmd.sh >> ~/.alias
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
                    1) 
                        echo '----------------------------------------'
                        check_command bash && bash_config
                        ;;
                    2) 
                        echo '----------------------------------------'
                        check_command zsh && zsh_config
                        ;;
                    3) 
                        echo '----------------------------------------'
                        check_command vim && vim_config
                        ;;
                    4) 
                        echo '----------------------------------------'
                        check_command git && git_config
                        ;;
                    5) 
                        echo '----------------------------------------'
                        check_command tmux && tmux_config
                        ;;
                    6) 
                        echo '----------------------------------------'
                        proxy_config
                        ;;
                    *) 
                        echo "${index} is invalid value."
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
