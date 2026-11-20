#!/usr/bin/env bash

set -e

# 포트 전환
function switch_proxy() {
    # health.sh에서 전달받은 포트
    local IDLE_PORT=$1

    echo "> 전환할 Port: $IDLE_PORT"
    echo "> Service URL Port 전환"
    echo "set \$service_url http://127.0.0.1:${IDLE_PORT};" \
      | sudo tee /etc/nginx/conf.d/service-url.inc

    echo "> Nginx Reload"
    sudo service nginx reload
}