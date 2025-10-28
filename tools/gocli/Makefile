# プロジェクト名（バイナリ名）
APP_NAME := gocli
APP_DIR := $(HOME)/dotfiles/tools/gocli
OUT_DIR := $(HOME)/dotfiles/tools/gocli/.out

# デフォルトターゲット
.PHONY: all
all: build

# クロスプラットフォームビルド
.PHONY: build
build:
	@echo "🔧 Building $(APP_NAME) for current OS..."
	cd $(APP_DIR) && go build -o $(OUT_DIR)/$(APP_NAME)

# 各OS用ビルド（Linux, macOS, Windows）
.PHONY: build-all
build-all:
	@mkdir -p $(OUT_DIR)
	cd $(APP_DIR) && \
	echo "🐧 Linux amd64" && GOOS=linux GOARCH=amd64 go build -o $(OUT_DIR)/$(APP_NAME)_linux_amd64 && \
	echo "🍎 macOS arm64" && GOOS=darwin GOARCH=arm64 go build -o $(OUT_DIR)/$(APP_NAME)_macos_arm64 && \
	echo "🪟 Windows amd64" && GOOS=windows GOARCH=amd64 go build -o $(OUT_DIR)/$(APP_NAME)_windows_amd64.exe

# クリーン
.PHONY: clean
clean:
	rm -rf $(OUT_DIR)/$(APP_NAME)*
