# color name
reset_all='\[\033[0m\]'
bold='\[\033[1m\]'
under_lined='\[\033[4m\]'
black='\[\033[30m\]'
red='\[\033[31m\]'
green='\[\033[32m\]'
yellow='\[\033[33m\]'
blue='\[\033[34m\]'
magenta='\[\033[35m\]'
cyan='\[\033[36m\]'
white='\[\033[37m\]'
defalut='\[\033[39m\]'


# confirm color prompt
case "$TERM" in
    xterm*|konsole*|rxvt*) color_prompt='yes';;
esac
color_prompt='yes'


# git prompt
function prompt_git()
{
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "${branch}" ]; then
        #local work_status='●'
        #local cache_status='●'
        local work_status='+'
        local work_color='\033[31m'
        local cache_status='+'
        local cache_color='\033[31m'
        if ! git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' &> /dev/null && \
          git diff --no-ext-diff --quiet &> /dev/null; then
            work_status='-'
            work_color='\033[32m'
        fi
        if git diff --no-ext-diff --cached --quiet &> /dev/null; then
            cache_status='-'
            cache_color='\033[32m'
        fi
        if [ "${color_prompt}" == 'yes' ]; then
            echo -e "\033[1m\033[37m<\033[34m${branch}${work_color}${work_status}${cache_color}${cache_status}\033[37m>\033[0m"
        else
            echo -e "<${branch}${work_status}${cache_status}>"
        fi
    fi
}


# result status prompt
function prompt_status()
{
    local status=$?
    if [ "${color_prompt}" == 'yes' ]; then
        if [ ${status} -eq 0 ]; then
            echo -e '\033[1m\033[32m- \033[0m'
        else
            echo -e '\033[1m\033[31m! \033[0m'
        fi
    else
        if [ ${status} -eq 0 ]; then
            echo -e '- '
        else
            echo -e '! '
        fi
    fi
}


# PS1
if [ "${color_prompt}" == 'yes' ]; then
    PROMPT_INFO="${bold}${white}[${green}\u${yellow}@${magenta}\h${reset_all}:${under_lined}\w${reset_all}${bold}${white}]${reset_all}"
    PROMPT_NEWLINE='\n'
    PROMPT_SUFFIX_ROOT="${bold}${red}\\$ ${reset_all}"
    PROMPT_SUFFIX_USER="${bold}${cyan}\\$ ${reset_all}"
    if [ $UID -eq 0 ]; then
        export PS1="\$(prompt_status)${PROMPT_INFO}${PROMPT_NEWLINE}${PROMPT_SUFFIX_ROOT}"
    else
        #export PS1='$(prompt_status)'"${PROMPT_INFO}"'$(prompt_git)'"${PROMPT_NEWLINE}${PROMPT_SUFFIX_USER}"
        export PS1="\$(prompt_status)${PROMPT_INFO}\$(prompt_git)${PROMPT_NEWLINE}${PROMPT_SUFFIX_USER}"
    fi
else
    #export PS1='☁ [\u@\h:\w]$(prompt_git)\n➜ '
    #export PS1='☘ [\u@\h:\w]$(prompt_git)\n♪ '
    if [ $UID -eq 0 ]; then
        export PS1='$(prompt_status)[\u@\h:\w]\n\$ '
    else
        export PS1='$(prompt_status)[\u@\h:\w]$(prompt_git)\n\$ '
    fi
fi


# shopt
shopt -u autocd
shopt -u direxpand
shopt -s globstar
shopt -s checkwinsize
shopt -s cmdhist
shopt -s expand_aliases
shopt -s extglob
shopt -s extquote
shopt -s histappend
shopt -s lithist
shopt -s histreedit
shopt -s histverify
shopt -s interactive_comments


# history
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=100000
export HISTFILESIZE=100000
# export HISTTIMEFORMAT="%F "
export HISTCONTROL='ignorespace:erasedups'
# export HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'
export PROMPT_COMMAND='history -a'
set -o history


# static link library
[ -z "${BASE_LIBRARY_PATH}" ] && export BASE_LIBRARY_PATH="$LIBRARY_PATH"
export LIBRARY_PATH="${BASE_LIBRARY_PATH}"

# dynamic link library
[ -z "${BASE_LD_LIBRARY_PATH}" ] && export BASE_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${BASE_LD_LIBRARY_PATH}"

# env path
[ -z "${BASE_PATH}" ] && export BASE_PATH="$HOME/.bin::$PATH"
export PATH="${BASE_PATH}"


# alias
test -f $HOME/.alias && . $HOME/.alias

