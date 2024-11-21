#!/usr/bin/env bash

# update bash-completion
cd ~/.local/bash-completion/bash_completion && git pull origin master && cd -

# update git-completion
cd ~/.local/git-completion && /bin/rm git-completion.bash && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && cd -
