#!/bin/bash

REPOSITORY=/home/ec2-user/app/step3
SCRIPT_DIR=$REPOSITORY/scripts
PROJECT_NAME=springBootAwsWebService

echo "> Build 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/
# 하위 파일들은 서버에 두고 필요할 때만 적용을 고려
# 가능하면 기존 설정을 복구할 수 있도록 임시 파일 작성 후 교체하도록 절차 변경 고려
echo "> 배포 작업 스크립트 파일 복사"
find $REPOSITORY/zip/scripts -maxdepth 1 -name "*.sh" ! -name "deploy.sh" \
    -exec cp {} $SCRIPT_DIR/ \;
echo "> 배포 오케스트레이션 스크립트 파일 복사"
cd $REPOSITORY/zip/scripts/deploy.sh $REPOSITORY
echo "> Nginx 설정 파일 복사"
cp $REPOSITORY/zip/nginx/nginx.conf /etc/nginx/
cp $REPOSITORY/zip/nginx/service-url.inc /etc/nginx/conf.d/

echo "> 배포 스크립트 실행권한 추가"
chmod +x $REPOSITORY/deploy.sh
chmod +x $SCRIPT_DIR/*.sh

echo "> 현재 구동중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f "${PROJECT_NAME}.*.\jar")

echo "> 현재 구동중인 애플리케이션 pid : $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
        echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
        echo "> kill -15 $CURRENT_PID"
        kill -15 $CURRENT_PID
        sleep 5
fi

echo "> 새 애플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"
chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"
nohup java \
      -Dspring.config.location=classpath:/application.properties,\
classpath:/application-real.properties,\
/home/ec2-user/app/application-oauth.properties,\
/home/ec2-user/app/application-real-db.properties \
      -Dspring.profiles.active=real \
      -jar $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
