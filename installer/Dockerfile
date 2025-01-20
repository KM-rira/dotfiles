# ベースイメージにUbuntuを使用
FROM ubuntu:latest

# 必要なツールをインストール（aptを使うために更新などを実施）
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# install.sh をコンテナ内にコピー
COPY install.sh /app/install.sh

# install.sh の実行権限を付与
RUN chmod +x /app/install.sh

# rootユーザーで install.sh を実行する
CMD ["bash", "-c", "sudo /app/install.sh"]
