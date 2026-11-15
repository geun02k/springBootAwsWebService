#!/bin/bash

set -e

# 배포 시 stop.sh의 PID와 동알하면 제거해도 무방함
echo "> 배포 전, 기존 구동중인 애플리케이션 pid 확인"
# set -e 활성화로 인한 명령어 실패 시 스크립트 종료 방지
CURRENT_PID=$(pgrep -f "${PROJECT_NAME}.*.\jar" || true)
if [ -z $CURRENT_PID ]
then
  echo "> 기존 에 실행 중인 애플리케이션이 없습니다."
else
  echo "> 배포 전, 기존 구동중인 애플리케이션 pid : $CURRENT_PID"
fi

echo "> 새 애플리케이션 실행"
$SCRIPT_DIR/start.sh

echo "> 새 애플리케이션 정상 실행 확인 및 Nginx 프록시 변경"
$SCRIPT_DIR/health.sh

echo "> 기존 애플리케이션 종료"
$SCRIPT_DIR/stop.sh

echo "> 배포를 완료합니다."