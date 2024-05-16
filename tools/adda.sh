#!/bin/bash

adda() {
    cd $(git rev-parse --show-toplevel)

    git add $1 .

    echo "===== DONE ====="
}
