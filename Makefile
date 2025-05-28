# Makefile pour simplifier les commandes CryptPad
.PHONY: build up down logs shell clean restart status

# Build the Docker image
build:
	docker-compose build

# Start CryptPad in development mode
up:
	docker-compose up -d
	@echo "CryptPad development instance starting..."
	@echo "Access it at: http://localhost:2001"
	@echo "Wait a few seconds for initialization..."

# Stop CryptPad
down:
	docker-compose down

# Show logs
logs:
	docker-compose logs -f cryptpad-dev

# Get a shell inside the container
shell:
	docker-compose exec cryptpad-dev sh

# Clean everything (including volumes)
clean:
	docker-compose down -v
	docker rmi cryptpad-dev_cryptpad-dev 2>/dev/null || true

# Quick restart
restart:
	docker-compose restart cryptpad-dev

# Show status
status:
	docker-compose ps
