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
        docker compose -p $ORACLE_PROJECT -f $ORACLE_COMPOSE_FILE down
        docker compose -p $ORACLE_PROJECT -f $ORACLE_COMPOSE_FILE up --build --no-color --detach
    ;;
    kafka)
        docker compose -p $KAFKA_PROJECT -f $KAFKA_COMPOSE_FILE down
        docker compose -p $KAFKA_PROJECT -f $KAFKA_COMPOSE_FILE up --build --no-color --detach
    ;;
    redis)
        docker compose -p $REDIS_PROJECT -f $REDIS_COMPOSE_FILE down
        docker compose -p $REDIS_PROJECT -f $REDIS_COMPOSE_FILE up --build --no-color --detach
    ;;
    sandbox)
        docker compose -p $SANDBOX_PROJECT -f $SANDBOX_COMPOSE_FILE down
        docker compose -p $SANDBOX_PROJECT -f $SANDBOX_COMPOSE_FILE up --build --no-color --detach
    ;;
    esac
done

docker image prune -f
