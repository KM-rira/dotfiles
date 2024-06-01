#!bin/bash

commit() {
    if [ "$#" -eq 0 ]; then
        echo "===== NEED PARAMETER ====="
        return
    fi

    git commit -m "$*"
}
