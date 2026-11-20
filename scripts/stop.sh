#!/usr/bin/env bash

set -e

# deploy.sh에서 전달받은 기존 애플리케이션 포트
OLD_PORT=$1

echo "> ${OLD_PORT} 에서 기존 구동 중인 애플리케이션 pid 확인"

if [ -z ${OLD_PORT} ]
then
  echo "> 기존 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  OLD_PID=$(lsof -ti tcp:${OLD_PORT} || true)
  echo "> kill -15 ${OLD_PID}"
  kill -15 ${OLD_PID}
  sleep 5
fi
