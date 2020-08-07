#!/bin/sh

docker-compose --file docker-compose.test.yml up --build sut
docker-compose --file docker-compose.test.yml down --volumes --remove-orphans --rmi all
