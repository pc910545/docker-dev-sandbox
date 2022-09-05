#!/bin/bash

source env_local.sh

#create share network
docker network inspect $SANDBOX_PROJECT >/dev/null 2>&1 || \
    docker network create --driver bridge $SANDBOX_PROJECT

PARAMETERS=( "$@" )
[ "XX$PARAMETERS" = "XX" ] && PARAMETERS="sandbox";
[ "$PARAMETERS" = "all" ] && PARAMETERS=(
oracle
kafka
redis
sandbox
);

for var in "${PARAMETERS[@]}"
do
    case "$var" in
    oracle)
	      echo
        echo "Do you want to clean restart oracle db? This will drop any database on your oracle and init with CTBC-ABC/sql (y/n)?"
        read -n 1 -t 30 -s GONOGO
        if [ "X${GONOGO/y/Y}" == "XY" ]
        then
	        echo "Removing: '${ORACLE_PROJECT}'"
          docker compose -p $ORACLE_PROJECT -f $ORACLE_COMPOSE_FILE down --rmi local -v --remove-orphans
          docker compose -p $ORACLE_PROJECT -f $ORACLE_COMPOSE_FILE up --force-recreate --build --no-color --detach
        else
          echo "Remove aborted"
        fi
    ;;
    kafka)
        echo
        echo "Do you want to clean restart redis? This will drop any data on your redis (y/n)?"
        read -n 1 -t 30 -s GONOGO
        if [ "X${GONOGO/y/Y}" == "XY" ]
        then
          echo "Removing: '${KAFKA_PROJECT}'"
          docker compose -p $KAFKA_PROJECT -f $KAFKA_COMPOSE_FILE down --rmi local -v --remove-orphans
          docker compose -p $KAFKA_PROJECT -f $KAFKA_COMPOSE_FILE up --force-recreate --build --no-color --detach
        else
          echo "Remove aborted"
        fi
    ;;    
    redis)
        echo
        echo "Do you want to clean restart redis? This will drop any data on your redis (y/n)?"
        read -n 1 -t 30 -s GONOGO
        if [ "X${GONOGO/y/Y}" == "XY" ]
        then
          echo "Removing: '${REDIS_PROJECT}'"
          docker compose -p $REDIS_PROJECT -f $REDIS_COMPOSE_FILE down --rmi local -v --remove-orphans
          docker compose -p $REDIS_PROJECT -f $REDIS_COMPOSE_FILE up --force-recreate --build --no-color --detach
        else
          echo "Remove aborted"
        fi
    ;;
    sandbox)
        echo
        echo "Do you want to clean restart sandbox? This will rebuild your sandbox (y/n)?"
        read -n 1 -t 30 -s GONOGO
        if [ "X${GONOGO/y/Y}" == "XY" ]
        then
          echo "Removing: '${SANDBOX_PROJECT}'"
          docker compose -p $SANDBOX_PROJECT -f $SANDBOX_COMPOSE_FILE down --rmi local -v --remove-orphans
          docker compose -p $SANDBOX_PROJECT -f $SANDBOX_COMPOSE_FILE build --no-cache
          docker compose -p $SANDBOX_PROJECT -f $SANDBOX_COMPOSE_FILE up --force-recreate --no-color --detach
        else
          echo "Remove aborted"
        fi
    ;;
    esac
done

docker image prune -f

# Delete network
#docker network remove $SANDBOX_PROJECT
#docker network create --driver bridge $SANDBOX_PROJECT

# Delete all docker resource
#docker system prune -a -f
#docker volume prune -f
