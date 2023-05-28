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
	@docker system prune --all --force --volumes






#danger-open='\033[31;49m'
#danger-close='\033[39m'


#delete_msg = "Do you really want to drop all containers from the system? [y/n] > "
#CONFIRMATION ?= $(shell bash -c 'read -p ${delete_msg} result; echo $${result}')

#drop-all:
#	@printf "$(danger-open)\nATTENTION!\n"
#	@printf "\033[31;49m\nAttention!\nAll containers will be removed from docker system.\033[39m\n\n"
#	@printf "$(CONFIRMATION)"
#	@docker stop $$(docker ps -a -q) && docker rm $$(docker ps -a -q)
#	@printf $(danger-close)



# docker rmi $(docker images -qa) - remove all downloaded docker images
# docker volume rm -f $(docker volume ls -q) - remove all volumes
# docker rm -v $(docker ps -aq) Все без исключения контейнеры будут удалены
# docker rm -v $(docker ps -aq -f status=exited) Удаление всех неактивных контейнеров
# docker network rm $(docker network ls -q) - remove all networks
# docker system prune -a -f - clear system from temp-files
# docker network ls -q - display networks
# docker volume ls -q [-a] - display active volumes [all]

# sudo systemctl stop docker
# sudo systemctl start docker
# sudo systemctl status docker
# docker ps -a -s (with size)




# ---------------------------------------------------------------------------------------------------------------------

#	USERNAME ?= $(shell bash -c 'read -p "Username: " username; echo $$username')
#	PASSWORD ?= $(shell bash -c 'read -s -p "Password: " pwd; echo $$pwd')
#	talk:
#		@clear
#		@echo 'Username › $(USERNAME)'
#		@echo 'Password › $(PASSWORD)'


#	build:
#	  @read -p "tag? : " TAG && echo "tag : $${TAG}"

#docker stop $$(docker ps -a -q) && docker rm $$(docker ps -a -q)
