#!/bin/bash

ARGS=("$@")

nvim "${ARGS[@]}"
EXIT_CODE=$?

while [ $EXIT_CODE -eq 1 ]; do
  nvim -c "lua require('persistence').load()" "${ARGS[@]}"
  EXIT_CODE=$?
done
