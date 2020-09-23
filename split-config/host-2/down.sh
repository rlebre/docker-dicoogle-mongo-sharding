#!/bin/bash

export COMPOSE_PROJECT_NAME=dicooglemongo
docker-compose down
rm -f ./mongodb.key