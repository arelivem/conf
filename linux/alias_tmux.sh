#!/usr/bin/env bash


function zsh_config() {
    local tmux_path=$(which tmux)
    echo -e '\n'                                                   >> ~/.alias
    echo '# tmux'                                                  >> ~/.alias
    echo 'function _tmux_new() {'                                  >> ~/.alias
    echo "    local tmux_cmd='${tmux_path}'"                       >> ~/.alias
    echo '    if [[ $# -gt 0 ]]; then'                             >> ~/.alias
    echo '        ${tmux_cmd} $@'                                  >> ~/.alias
    echo '    else'                                                >> ~/.alias
    echo '        ${tmux_cmd} attach || ${tmux_cmd} new-session'   >> ~/.alias
    echo '    fi'                                                  >> ~/.alias
    echo '}'                                                       >> ~/.alias
    echo 'alias tmux=_tmux_new'                                    >> ~/.alias
}


zsh_config
