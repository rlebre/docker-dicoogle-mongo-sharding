#!/bin/bash

## Composer project name instead of git main folder name
export COMPOSE_PROJECT_NAME=dicooglemongo

## Generate global auth key between cluster nodes
openssl rand -base64 756 > mongodb.key
chmod 400 mongodb.key
sudo chown 999:999 mongodb.key

## Start the docker-compose.yml stack
docker-compose up -d 

## Config servers setup
docker-compose exec config01 sh -c "mongo --port 27017 < /scripts/dicoogle-mongo-configserver.init.js"

## Shard servers setup
docker-compose exec shard01a sh -c "mongo --port 27018 < /scripts/dicoogle-mongo-shard01.init.js"
docker-compose exec shard02a sh -c "mongo --port 27019 < /scripts/dicoogle-mongo-shard02.init.js"
docker-compose exec shard03a sh -c "mongo --port 27020 < /scripts/dicoogle-mongo-shard03.init.js"

## Apply sharding configuration after 40 seconds waiting
sleep 40
docker exec -it dicooglemongo_router_1 sh -c "mongo --port 8081 < /scripts/dicoogle-mongo-router.init.js"

## Enable admin account on router
docker exec -it dicooglemongo_router_1 sh -c "mongo --port 8081 < /scripts/dicoogle-mongo-auth.init.js"