.DEFAULT_GOAL := help
.PHONY: help

spec_path ?= spec/**/*_spec.rb

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

up: ## Run app and all dependant services 
	docker-compose up

down: ## Drop app and all dependant services  
	docker-compose down

specs: ## Run specs with optional `spec_opts`, e.g. make specs spec_opts='spec/models/user_spec.rb:15'
	docker-compose --profile test run --rm app_test rspec $(spec_opts)

console: ## rails console
	docker-compose run --rm app rails c

bash: ## app bash shell
	docker-compose run --rm app bash

db_create: ## rails db:create
	docker-compose run --rm app rails db:create

db_migrate: ## rails db:migrate
	docker-compose run --rm app rails db:migrate

db_migrate_test: ## rails db:migrate RAILS_ENV=test
	DISABLE_SPRING=true RAILS_ENV=test
	docker-compose run --rm app rails db:migrate
