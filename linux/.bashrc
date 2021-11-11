# color name
reset_all='\[\033[0m\]'
bold='\[\033[1m\]'
reset_bold='\[\003[21m\]'
under_lined='\[\033[4m\]'
cyan='\[\033[36m\]'
light_grey='\[\033[37m\]'
green='\[\033[32m\]'
yellow='\[\033[33m\]'
magenta='\[\033[35m\]'
red='\[\033[31m\]'
blue='\[033[34m\]'
default='\[\033[39m\]'

# confirm color prompt
case "$TERM" in
    xterm*|*-256color|rxvt*) color_prompt=yes;;
esac

# git prompt
function __prompt_git()
{
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ ${#branch} -ne 0 ]; then
        local s_work='\033[31m●'
        local s_cache='\033[31m●'
        if ! git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' &> /dev/null && \
          git diff --no-ext-diff --quiet &> /dev/null; then
            s_work='\033[32m●'
        fi
        if git diff --no-ext-diff --cached --quiet &> /dev/null; then
            s_cache='\033[32m●'
        fi
        if [ "${color_prompt}" == 'yes' ]; then
            echo -e "\033[1;37m<\033[34m${branch}${s_work}${s_cache}\033[37m>\033[0m"
        else
            echo -e "<${branch}>"
        fi
    fi
}

# PS1
if [ "${color_prompt}" == 'yes' ]; then
    PROMPT_PREFIX="${bold}${cyan}☁ ${light_grey}[${green}\u${yellow}@${magenta}\h${reset_all}:${under_lined}\w${reset_all}${bold}${light_grey}]${reset_all} "
    PROMPT_NEWLINE="${reset_all}\n${reset_all}"
    PROMPT_SUFFIX="${bold}${cyan}➜ ${reset_all}"
    PS1="${PROMPT_PREFIX}"'$(__prompt_git)'"${PROMPT_NEWLINE}""${PROMPT_SUFFIX}"
else
    PS1='☁ [\u@\h:\w]$(__prompt_git)\[\e[m\]\n➜ \[\e[m\]'
fi

# shopt
shopt -s checkwinsize
shopt -s cmdhist
shopt -s lithist
shopt -s expand_aliases
shopt -s extglob
shopt -s extquote
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s interactive_comments

# history
export HISTFILE=$HOME/.bash_history
export HISTSIZE=10000
export HISTFILESIZE=30000
# export HISTTIMEFORMAT="%F "
export HISTCONTROL=ignoreboth
# export HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'
export PROMPT_COMMAND='history -a'
set -o history

# rename rm
alias rm='trash -F'  # mac

alias rm=__rm
function __rm()
{
    mv --backup=t $@ $HOME/.Trash/
}

alias clean-trash=__clean_trash
function __clean_trash()
{
    read -p "clean .Trash? (y or n) " confirm
    [ "$confirm" == 'y' ] || [ "$confirm" == 'Y' ] && /bin/rm -rf $HOME/.Trash/*
}

# tmux
alias tmux=__tmux
function __tmux()
{
    tmux_cmd='command tmux' # command cancels all alias.
    if [ $# -gt 0 ]; then
        $tmux_cmd $@
    else
        $tmux_cmd attach
        if [ $? -ne 0 ]; then
            $tmux_cmd new-session
        fi
    fi
}

# bash completion
# https://github.com/scop/bash-completion
[ -f $HOME/.local/bash-completion/bash_completion ] && \
    . $HOME/.local/bash-completion/bash_completion

# git completion
# https://github.com/git/git/tree/master/contrib/completion
[ -f $HOME/.local/git-completion/git-completion.bash ] && \
    . $HOME/.local/git-completion/git-completion.bash

# alias
alias sh='/bin/bash'
alias ls='ls -F --color=auto'  # linux
# alias ls='ls -FG'  # mac
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -Alh'
alias la='ls -A'
alias l='ls -Clh'
alias vi='vim'
alias man='tldr'


# static link library
if [ -z "$ORIGIN_LIBRARY_PATH" ]; then
    export ORIGIN_LIBRARY_PATH="$LIBRARY_PATH"
fi
export LIBRARY_PATH="$ORIGIN_LIBRARY_PATH"
# dynamic link library
if [ -z "$ORIGIN_LD_LIBRARY_PATH" ]; then
    export ORIGIN_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
fi
export LD_LIBRARY_PATH="$ORIGIN_LD_LIBRARY_PATH"
# env path
if [ -z "$ORIGIN_PATH" ]; then
    export ORIGIN_PATH="$HOME/.bin:$PATH"
fi
export PATH="$ORIGIN_PATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME/.local/anaconda/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f $HOME/.local/anaconda/etc/profile.d/conda.sh ]; then
        . $HOME/.local/anaconda/etc/profile.d/conda.sh
    else
        export PATH="$HOME/.local/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

