FILE_PATH = src/docker-compose.yaml

BASE_CMD = docker compose -f ${FILE_PATH}

build:
	${BASE_CMD} build

up:
	${BASE_CMD} up

up-d:
	${BASE_CMD} up -d

down:
	${BASE_CMD} down

down-v:
	${BASE_CMD} down -v

start:
	${BASE_CMD} start

stop:
	${BASE_CMD} stop

restart:
	${BASE_CMD} restart

status:
	${BASE_CMD} ps

.PHONY: build up up-d down down-d start stop restart status
