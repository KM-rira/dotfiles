# Dockerイメージ名とタグを定義
IMAGE_NAME = test-install-script
CONTAINER_NAME = test-container

# デフォルトターゲット
.PHONY: all
all: build run test

# Dockerイメージをビルド
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# コンテナを実行（bashシェルに入る）
.PHONY: run
run:
	docker run --rm -it --name $(CONTAINER_NAME) $(IMAGE_NAME) bash

# テストを実行
.PHONY: test
test:
	docker build -t $(IMAGE_NAME) .
	docker run --rm test-install-script

# クリーンアップ（必要なら追加）
.PHONY: clean
clean:
	docker image rm -f $(IMAGE_NAME)
