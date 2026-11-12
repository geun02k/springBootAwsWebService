#!/bin/bash

# 배포 시 stop.sh의 PID와 동알하면 제거해도 무방함
echo "> 배포 전, 기존 구동중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f "${PROJECT_NAME}.*.\jar")
echo "> 배포 전, 기존 구동중인 애플리케이션 pid : $CURRENT_PID"

echo "> 새 애플리케이션 실행"
$SCRIPT_DIR/start.sh

echo "> 새 애플리케이션 정상 실행 확인 및 Nginx 프록시 변경"
$SCRIPT_DIR/health.sh

echo "> 기존 애플리케이션 종료"
$SCRIPT_DIR/stop.sh
