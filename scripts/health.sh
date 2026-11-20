#!/usr/bin/env bash

set -e

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/switch.sh

# deploy.sh에서 전달받은 새 애플리케이션 포트
IDLE_PORT=$1

echo "> Health Check Start!"
echo "> IDLE_PORT: $IDLE_PORT"
echo "> curl -s http://localhost:$IDLE_PORT/profile 수행"
sleep 10

for RETRY_COUNT in {1..10}
do
	RESPONSE=$(curl -s http://localhost:${IDLE_PORT}/profile || true)
	UP_COUNT=$(echo ${RESPONSE} | grep 'real' | wc -l)

  # "real" 문자열이 있는지 검증
	if [ ${UP_COUNT} -ge 1 ] # real 문자열 존재
	then
		echo "> Health check 성공"
		# Nginx 프록시 대상 변경 (Health Check에 성공한 포트를 Nginx에 전달)
		switch_proxy "$IDLE_PORT"
		break
	else # real 문자열 미존재
		echo "> Health check의 응답을 알 수 없거나 혹은 실행 상태가 아닙니다."
		echo "> Health check: ${RESPONSE}"
	fi

	if [ ${RETRY_COUNT} -eq 10 ]
	then
		echo "> Health check 실패"
		echo "> Nginx에 연결하지 않고 배포를 종료합니다."
		exit 1
	fi

	echo "> Health check 연결 실패. 재시도... ${RETRY_COUNT}"
	sleep 10
done