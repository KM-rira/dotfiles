#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "You are not root."
    echo 1
fi

apt update
apt install -y bat

