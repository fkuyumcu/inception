DC := docker-compose -f srcs/docker-compose.yml

all:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

clean:
	@$(DC) down -v --remove-orphans
	@docker rmi -f $$(docker images -q)

cc: 
	@$(DC) down -v --remove-orphans
	@docker rmi -f $$(docker images -q) 2>/dev/null || true
	@docker builder prune -af
	@sudo rm -rf ~/data/wordpress ~/data/mysql


.PHONY: all down re clean cc
