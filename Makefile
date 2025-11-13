DC := docker-compose -f srcs/docker-compose.yml

all:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

cc: 
	@$(DC) down -v --remove-orphans
	@docker rmi -f $$(docker images -q) 2>/dev/null || true
	@docker builder prune -af
	@sudo rm -rf ~/data/wordpress ~/data/mysql

clean:
	@$(DC) down -v --remove-orphans     # Down ile konteynerleri durdurur ve bağlı volumeleri kaldırır
	@docker rmi -f $$(docker images -q) # Kullanılmayan imajları siler

.PHONY: all down re clean cc
