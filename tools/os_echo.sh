#!/bin/bash

OS=$(uname)

case $OS in
    'Linux')
        echo "Linux"
        ;;
    'Darwin')
        echo "Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        echo "Windows"
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac