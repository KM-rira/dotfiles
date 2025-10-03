FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    file \
    git \
    sudo \
    cargo \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Homebrew 用ユーザーを作成
RUN useradd -m -s /bin/bash linuxbrew && \
    echo "linuxbrew ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# スクリプトをコピー（root のうちに）
WORKDIR /app
COPY normal_install.sh /app/normal_install.sh
COPY sudo_install.sh /app/sudo_install.sh
RUN chmod +x /app/*.sh && chown linuxbrew:linuxbrew /app/*.sh

# linuxbrew ユーザーで Homebrew インストール
USER linuxbrew
WORKDIR /home/linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# コンテナ実行時のコマンド
CMD ["/bin/bash", "-c", "/app/normal_install.sh"]

