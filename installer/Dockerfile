FROM ubuntu:latest

# 必要パッケージ
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    file \
    git \
    && rm -rf /var/lib/apt/lists/*

# Homebrew インストール
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# PATH を通す
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Homebrew 初期化（ログインシェルで反映させる用）
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc

WORKDIR /app

# スクリプトをコピー
COPY normal_install.sh /app/normal_install.sh
COPY sudo_install.sh /app/sudo_install.sh

RUN chmod +x /app/sudo_install.sh
RUN chmod +x /app/normal_install.sh

# root ユーザーで直接実行
CMD ["/app/sudo_install.sh"]
CMD ["/app/normal_install.sh"]

