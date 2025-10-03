# ベースイメージにUbuntuを使用
FROM ubuntu:latest

# 必要なツールをインストール（aptを使うために更新などを実施）
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Homebrew インストール
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 環境変数の設定（Linuxbrew のパスを通す）
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Homebrew の初期化
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc

# 作業ディレクトリを設定
WORKDIR /app

# install.sh をコンテナ内にコピー
COPY normal_install.sh /app/normal_install.sh
COPY sudo_install.sh /app/sudo_install.sh

# sudo_install.sh の実行権限を付与
RUN chmod +x /app/sudo_install.sh

# rootユーザーで sudo_install.sh を実行する
CMD ["bash", "-c", "sudo /app/sudo_install.sh"]
