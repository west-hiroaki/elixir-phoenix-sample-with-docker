DOCKER_COMPOSE = docker-compose

ensure:
	@./.tool-versions-ensure.sh

# 環境初期化
init: build up init_db deps.get npm.install

build:
	$(DOCKER_COMPOSE) build

# DB再作成
init_db:
	$(DOCKER_COMPOSE) exec mysql mysql -h127.0.0.1 -uroot -e'DROP DATABASE IF EXISTS my_phoenix_dev;CREATE DATABASE my_phoenix_dev DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;'

npm.install: ensure
	cd my_app/assets && npm install

deps.get: ensure
	cd my_app && mix deps.get $(ARGS)

deps.update: ensure
	cd my_app && mix deps.update $(ARGS)

deps.clean: ensure
	cd my_app && mix deps.clean $(ARGS)

dialyzer: ensure
	cd my_app && mix dialyzer $(ARGS)

migrate:
	$(DOCKER_COMPOSE) run --rm python_app python manage.py migrate

up:
	$(DOCKER_COMPOSE) up -d

# phoenix サーバ起動
server: up
	cd my_app && mix phx.server

ps:
	$(DOCKER_COMPOSE) ps

down:
	$(DOCKER_COMPOSE) down

stop:
	$(DOCKER_COMPOSE) stop

logs:
	$(DOCKER_COMPOSE) logs

# mysqlアプリコンテナにbash接続
bash:
	$(DOCKER_COMPOSE) exec mysql bash
