#!/usr/bin/env bash

# 현재 stop.sh 파일의 절대 경로
ABSPATH="$(readlink -f $0)"
# 현재 stop.sh 파일이 존재하는 디렉터리
ABSDIR=$(dirname $ABSPATH)
# profile.sh import
source ${ABSDIR}/profile.sh

IDLE_PORT=$(find_idle_port)

echo "> $IDLE_PORT 에서 기존 구동 중인 애플리케이션 pid 확인"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> 기존 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  sleep 5
fi
