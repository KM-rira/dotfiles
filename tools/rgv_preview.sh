#!/bin/bash

ROW_NUM=$1
SELECT_FILE=$2
EXT="${SELECT_FILE##*.}"


ROW_NUM=$(echo "$ROW_NUM" | cut -d ':' -f 1)

ADD_VALUE=$((ROW_NUM + 10))
SUB_VALUE=$((ROW_NUM - 10))

ROW_DATA=$(sed -n "${SUB_VALUE},${ADD_VALUE}p" "$SELECT_FILE")

echo "$ROW_DATA" > "${HOME}/.tmp/tmp.${EXT}"
