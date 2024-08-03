#!/bin/bash

notegen() {
    FILENAME="$HOME/note/$(date '+%Y%m%d-%H%M%S').md"
    echo -e "# TITLE: \n\n" > $FILENAME
    v $FILENAME
}

