#!/bin/bash
export PROJECT_HOME="~/CTBC-ABC"

export SANDBOX_PROJECT="docker-dev-ctbc-abc";
export SANDBOX_COMPOSE_FILE='docker-compose-sandbox.yaml';

export ORACLE_PROJECT="docker-dev-oracle";
export ORACLE_COMPOSE_FILE='docker-compose-oracle.yaml';

export KAFKA_PROJECT="docker-dev-kafka";
export KAFKA_COMPOSE_FILE='docker-compose-kafka.yaml';

export REDIS_PROJECT="docker-dev-redis";
export REDIS_COMPOSE_FILE='docker-compose-redis.yaml';

export TAG="${GIT_COMMIT:-$(git describe --long --dirty --abbrev=10 --tags --always)}";
export GIT_COMMIT="ff$(git rev-parse HEAD)";

# overwrite env
source env_local_overwrite.sh