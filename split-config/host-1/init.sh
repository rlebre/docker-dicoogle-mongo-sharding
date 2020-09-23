#!/bin/bash

## Composer project name instead of git main folder name
export COMPOSE_PROJECT_NAME=dicooglemongo

## Generate global auth key between cluster nodes
openssl rand -base64 756 > mongodb.key
chmod 400 mongodb.key
sudo chown 999:999 mongodb.key

## Start the docker-compose.yml stack
docker-compose up -d 

## Shard servers setup
docker-compose exec shard01a sh -c "mongo --port 27018 < /scripts/dicoogle-mongo-shard01.init.js"