#!/bin/bash

# confirm wget installed
if [ -z $(which wget) ]; then
    echo "wget is not installed, please try again after installation."
    exit 1
fi

# confirm tldr installed
if [ -z $(which tldr) ]; then
    echo "tldr is not installed, please try again after installation."
    exit 1
fi

# confirm tmux installed
if [ -z $(which tmux) ]; then
    echo "tmux is not installed, please try again after installation."
    exit 1
fi

# config inputrc (hot keys)
/bin/rm -rf ~/.inputrc && cp ./.inputrc ~/

# config bashrc
/bin/rm -rf ~/.bash_history && touch ~/.bash_history
/bin/rm -rf ~/.Trash/ ~/.bin/ ~/.local
mkdir ~/.Trash/ ~/.bin/ ~/.local
cd ~/.local/ && git clone https://github.com/scop/bash-completion.git && cd -
mkdir ~/.local/git-completion && cd ~/.local/git-completion && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && cd -
/bin/rm -rf ~/.bashrc && cp ./.bashrc ~/

# config vim
/bin/rm -rf ~/.vim
mkdir -p ~/.vim/undo ~/.vim/autoload ~/.config/vim
cd ~/.vim/autoload && wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && cd -
/bin/rm -rf ~/.vimrc && cp ./.vimrc ~/

# config git
git config --global user.email "arelive@yeah.net"
git config --global user.name "arelivem"
git config --global credential.helper store  # config credential type
git config --global credential.useHttpPath true  # config match git path

# config tmux
/bin/rm -rf ~/.tmux.conf && cp ./.tmux.conf ~/

echo "============================================================="
echo "Install finished."
echo ""
echo "Log out and log in again for the settings to take effect."
echo "============================================================="
