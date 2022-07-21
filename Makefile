include .env
shell_name = zsh


# build exec
all: build exec

## docker image関連
# dockerfile->imageの作成
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) --no-cache .

## dockerの確認コマンド
# 確認
.PHONY: images
images:
	docker images

# コンテナを一覧表示
.PHONY: ps
ps:
	docker compose ps -a

# dockerのlogを表示
.PHONY: logs
logs:
	docker compose logs

## dockerの実行コマンド
.PHONY: up
up:
	docker compose up -d --build

# 実行
.PHONY: exec
exec:
	@make up
	docker compose exec app ${shell_name}

# コンテナを停止
.PHONY: stop
stop:
	docker compose stop

# コンテナを停止して削除
.PHONY: down
down:
	docker compose down --remove-orphans

# dockerの未使用オブジェクトを削除
.PHONY: prune
prune:
	docker system prune -af

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | python3 -u -c 'import sys, re; rx = re.compile(r"^[a-zA-Z0-9\-_]+:"); lines = [line.rstrip() for line in sys.stdin if not line.startswith(".PHONY")]; [print(f"""{line.split(":")[0]:20s}\t{prev.lstrip("# ")}""") if rx.search(line) and prev.startswith("# ") else print(f"""\n\033[92m{prev.lstrip("## ")}\033[0m""") if prev.startswith("## ") else "" for prev, line in zip([""] + lines, lines)]'
