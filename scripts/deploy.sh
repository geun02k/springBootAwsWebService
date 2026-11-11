#!/bin/bash

echo "> 현재 구동중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f "${PROJECT_NAME}.*.\jar")

echo "> 현재 구동중인 애플리케이션 pid : $CURRENT_PID"

echo "> 새 애플리케이션 실행"
$SCRIPT_DIR/start.sh

echo "> 새 애플리케이션 정상 실행 확인 및 Nginx 프록시 변경"
$SCRIPT_DIR/health.sh

if [ -z "$CURRENT_PID" ]; then
        echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
        echo "> kill -15 $CURRENT_PID"
        kill -15 $CURRENT_PID
        sleep 5
fi
