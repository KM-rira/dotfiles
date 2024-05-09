#!bin/bash

commit() {
    if [ "$#" -eq 0 ]; then
        echo "===== need parameter ====="
        return
    fi

    git commit -m "$*"
}
