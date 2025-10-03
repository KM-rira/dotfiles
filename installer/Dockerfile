FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    file \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Homebrew 用ユーザーを作成
RUN useradd -m -s /bin/bash linuxbrew && \
    echo "linuxbrew ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER linuxbrew
WORKDIR /home/linuxbrew

# Homebrew インストール
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# PATH 設定
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# スクリプトをコピー
COPY normal_install.sh /app/normal_install.sh
COPY sudo_install.sh /app/sudo_install.sh

RUN chmod +x /app/sudo_install.sh
RUN chmod +x /app/normal_install.sh

CMD ["/bin/bash", "-c", "/app/sudo_install.sh && /app/normal_install.sh"]

