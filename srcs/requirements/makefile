DC := docker-compose -f docker-compose.yml

all:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

cc: 
	@echo "Stopping all containers..."
	@$(DC) down -v --remove-orphans
	@echo "Removing all Docker images..."
	@docker rmi -f $$(docker images -q) 2>/dev/null || true
	@echo "Removing all build cache..."
	@docker builder prune -af
	@echo "Cleaning local volumes..."
	@sudo rm -rf ~/data/wordpress ~/data/mysql
	@echo "Complete clean finished!"

clean:
	@$(DC) down -v --remove-orphans     # Down ile konteynerleri durdurur ve bağlı volumeleri kaldırır
	@docker rmi -f $$(docker images -q) # Kullanılmayan imajları siler

.PHONY: all down re clean cc