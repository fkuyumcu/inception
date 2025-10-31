DC := docker-compose -f docker-compose.yml

all:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

clean:
	@$(DC) down -v --remove-orphans     # Down ile konteynerleri durdurur ve bağlı volumeleri kaldırır
	@docker rmi -f $$(docker images -q) # Kullanılmayan imajları siler

.PHONY: all down re clean