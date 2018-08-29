#!/usr/bin/env bash

git pull

export PROJECT_PATH=/home/vagrant/MSA_POC
export LOG_PATH=$PROJECT_PATH/logs

# log path create
if [ ! -d $LOG_PATH ]; then
   mkdir $LOG_PATH;
fi

# config server start
nohup mvn -f $PROJECT_PATH/pom.xml -pl config -am spring-boot:run >> $LOG_PATH/config.log &
echo $! > config.pid

while [ -z ${CONFIG_SERVER_READY} ]; do
  echo "Waiting for config server..."
  if [ "$(curl --silent localhost:8888/actuator/health 2>&1 | grep -q '\"status\":\"UP\"'; echo $?)" = 0 ]; then
      CONFIG_SERVER_READY=true;
  fi
  sleep 2
done

echo -e "config server started...\n\n"

# eureka server start
nohup mvn -f $PROJECT_PATH/pom.xml -pl eureka -am spring-boot:run >> $LOG_PATH/eureka.log &
echo $! > eureka.pid

while [ -z ${EUREKA_SERVER_READY} ]; do
  echo "Waiting for eureka server..."
  if [ "$(curl --silent localhost:8761/actuator/health 2>&1 | grep -q '\"status\":\"UP\"'; echo $?)" = 0 ]; then
      EUREKA_SERVER_READY=true;
  fi
  sleep 2
done

echo -e "eureka server started...\n\n"

# gateway server start
nohup mvn -f $PROJECT_PATH/pom.xml -pl gateway -am spring-boot:run >> $LOG_PATH/gateway.log &
echo $! > gateway.pid

while [ -z ${GATEWAY_SERVER_READY} ]; do
  echo "Waiting for gateway server..."
  if [ "$(curl --silent localhost:8080/actuator/health 2>&1 | grep -q '\"status\":\"UP\"'; echo $?)" = 0 ]; then
      GATEWAY_SERVER_READY=true;
  fi
  sleep 2
done

echo -e "gateway server started..."

exit 0
