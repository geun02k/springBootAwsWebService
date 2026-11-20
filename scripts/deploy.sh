#!/bin/bash

set -e

REPOSITORY=/home/ec2-user/app/step3
SCRIPT_DIR=$REPOSITORY/scripts
PROJECT_NAME=springBootAwsWebService
source $SCRIPT_DIR/profile.sh

echo "> 현재 Nginx Service URL 설정"
cat /etc/nginx/conf.d/service-url.inc
echo "> 8081 포트로 실행되는 PID : $(lsof -ti tcp:8081)"
echo "> 8082 포트로 실행되는 PID : $(lsof -ti tcp:8082)"

echo "> 신규 애플리케이션 실행 프로필 및 포트 결정"
IDLE_PROFILE=$(find_idle_profile)
NEW_PORT=$(find_port_by_profile "$IDLE_PROFILE")
OLD_PORT=$(find_reverse_port "$NEW_PORT")
echo "> profile-$IDLE_PROFILE, port-$NEW_PORT 로 배포를 실행합니다."

# 배포 시 stop.sh의 PID와 동알하면 제거해도 무방함
echo "> 배포 전, 기존 구동중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f "${PROJECT_NAME}.*.\jar" || true)

if [ -z $CURRENT_PID ]
then
  echo "> 기존 에 실행 중인 애플리케이션이 없습니다."
else
  echo "> 배포 전, 기존 구동중인 애플리케이션 pid : $CURRENT_PID"
fi

echo "> 새 애플리케이션 실행"
$SCRIPT_DIR/start.sh "$IDLE_PROFILE"

echo "> 새 애플리케이션 정상 실행 확인 및 Nginx 프록시 변경"
$SCRIPT_DIR/health.sh "$NEW_PORT"

echo "> 기존 애플리케이션 종료"
$SCRIPT_DIR/stop.sh "$OLD_PORT"

echo "> 배포를 완료합니다."