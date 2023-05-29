# Symfony 6.0 application skeleton
# Including environment files (.env, .env.local).
ifndef APP_ENV
	include .env
	# Determine if .env.local file exist
	ifneq ("$(wildcard .env.local)","")
		include .env.local
	endif
endif

# Get variables from environment file
app_dir = ${CURDIR}
app_name = ${APP_NAME}
console = php bin/console

compose := docker-compose -f '.docker/docker-compose.yml' -p '$(app_name)' --env-file='.env'

# General commands:
build: up ps
rebuild: rm up

up:
	$(compose) up -d --build --remove-orphans

stop:
	$(compose) stop

down:
	$(compose) down

ps:
	$(compose) ps

logs:
	$(compose) logs -f

rm:
	$(compose) rm -f --stop

ssh:
	@docker exec -t -i '$(app_name)-php-fpm' bash

db:
	@docker exec -t -i '$(app_name)-database' bash

test:
	$(compose) top

# Service commands:
drop-all:
	@printf "\033[31;49m\nAttention!\nAll containers will be removed from system.\033[39m\n\n"
	@docker stop $$(docker ps -a -q)
	@docker rm $$(docker ps -a -q)
	@docker rmi $$(docker images -qa)
	@docker volume rm -f $$(docker volume ls -q)
	@docker network rm $$(docker network ls -q)

prune:
	@docker system prune --all --force --volumes

