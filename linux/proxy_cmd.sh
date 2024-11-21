

# cmd proxy
function proxy_cmd() {
    if [[ "$1" == 'start' ]]; then
        if [[ -z "$2" ]]; then
            echo 'usage: proxy_cmd (start | stop) proxy_port'
            return 0
        fi
        local proxy_port="$2"
        local proxy_ip='127.0.0.1'
        export https_proxy="http://${proxy_ip}:${proxy_port}"
        export http_proxy="http://${proxy_ip}:${proxy_port}"
        export all_proxy="socks5://${proxy_ip}:${proxy_port}"
    elif [[ "$1" == 'stop' ]]; then
        export https_proxy=''
        export http_proxy=''
        export all_proxy=''
    else
        echo 'usage: proxy_cmd (start | stop) proxy_port'
    fi
}
