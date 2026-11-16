#!/usr/bin/env bash

set -e

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

REPOSITORY=/home/ec2-user/app/step3
SCRIPT_DIR=$REPOSITORY/scripts
PROJECT_NAME=springBootAwsWebService

echo "> Build 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/
# 하위 파일들은 서버에 두고 필요할 때만 적용을 고려
# 가능하면 기존 설정을 복구할 수 있도록 임시 파일 작성 후 교체하도록 절차 변경 고려

echo "> 새 애플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)
echo "> JAR name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"
chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"
IDLE_PROFILE=$(find_idle_profile)

echo "> $JAR_NAME 을 profile-$IDLE_PROFILE 로 실행합니다."
nohup java \
      -Dspring.config.location=classpath:/application.properties,\
classpath:/application-$IDLE_PROFILE.properties,\
/home/ec2-user/app/application-oauth.properties,\
/home/ec2-user/app/application-real-db.properties \
      -Dspring.profiles.active=$IDLE_PROFILE \
      -jar $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
