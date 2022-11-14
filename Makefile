FILE_PATH = src/docker-compose.yaml

PROJECT_NAME = inception

BASE_CMD = docker compose --file ${FILE_PATH} --project-name ${PROJECT_NAME}

build:
	${BASE_CMD} build

up:
	${BASE_CMD} up --build

up-d:
	${BASE_CMD} up --build --detach

down:
	${BASE_CMD} down

clean:
	${BASE_CMD} down --volumes --rmi all --remove-orphans
	docker system prune --force

start:
	${BASE_CMD} start

stop:
	${BASE_CMD} stop

restart:
	${BASE_CMD} restart

status:
	${BASE_CMD} ps

.PHONY: up up-d down down-v remove start stop restart status
