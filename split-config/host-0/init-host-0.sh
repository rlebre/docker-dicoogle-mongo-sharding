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

## Apply sharding configuration after user input
read -n 1 -s -r -p "Wait until shards elect a primary node. Then, press any key to continue..."
docker exec -it dicooglemongo_router_1 sh -c "mongo --port 8081 < /scripts/dicoogle-mongo-router.init.js"

## Enable admin account on router
docker exec -it dicooglemongo_router_1 sh -c "mongo --port 8081 < /scripts/dicoogle-mongo-auth.init.js"