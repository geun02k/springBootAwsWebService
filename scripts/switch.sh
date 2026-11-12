#!/usr/bin/env bash

ABSPATH=$(readlink 0f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

# 포트 전환
function switch_proxy() {
    IDLE_PORT=$(find_idle_port)

    echo "> 전환할 Port: $IDLE_PORT"
    echo "> Service URL Port 전환"
    echo "set \$service_url http://127.0.0.1:${IDLE_PORT};" \
      | sudo tee /etc/nginx/conf.d/service-url.inc

    echo "> Nginx Reload"
    sudo servive nginx reload
}