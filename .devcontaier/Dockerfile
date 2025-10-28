FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      neovim \
      fd-find \
      bat \
      ripgrep \
      git curl ca-certificates locales && \
    sed -i 's/# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    sed -i 's/# \(ja_JP.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen && update-ca-certificates && \
    ln -sf "$(command -v fdfind)" /usr/local/bin/fd && \
    ln -sf /usr/bin/batcat /usr/local/bin/bat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-lc"]

