#!/usr/bin/env bash

# 쉬고 있는 profile 찾기 (real1이 사용중이면 real2가 쉬고 있고, 반대면 real1이 쉬고 있음)
function find_idle_profile() {
  # HTTP 요청에 대한 응답에서 HTTP 상태 코드 추출
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://localhost/profile)

  # 두 애플리케이션이 모두 응답하지 않거나 Nginx 자체에 문제가 생긴 경우에도 real1을 유휴 프로필로 판단.
  # 실제 무중단 배포에서는 이런 상황을 구분하는 로직을 나중에 보완 필요.
  if [ ${RESPONSE_CODE} -ge 400 ] # 400 이상의 예외 발생 시
  then
    CURRENT_PROFILE=real2
  else
    CURRENT_PROFILE=$(curl -s http://localhost/profile)
  fi

  # 현재 nginx와 연결되지 않은 profile
  if [ ${CURRENT_PROFILE} == real1 ]
  then
    IDLE_PROFILE=real2
  else
    IDLE_PROFILE=real1
  fi

  echo "${IDLE_PROFILE}"
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port() {
  IDLE_PROFILE=${find_idle_profile}

  if [ ${IDLE_PROFILE} == real1 ]
  then
    echo "8081"
  else
    echo "8082"
  fi
}
