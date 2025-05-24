#!/bin/bash

if [ -n "$XDG_RUNTIME_DIR" ]; then
  SOCKET_BASE_DIR="$XDG_RUNTIME_DIR/nvim_sockets"
else
  SOCKET_BASE_DIR="/tmp/nvim.$USER"
fi
mkdir -p "$SOCKET_BASE_DIR"

SOCKET_UUID=$(uuidgen)
SOCKET_PATH="${SOCKET_BASE_DIR}/${SOCKET_UUID}.sock"
ARGS=("$@")

nvim \
  --listen "$SOCKET_PATH" \
  --cmd "let g:nvim_socket_path = '${SOCKET_PATH}'" \
  "${ARGS[@]}"
EXIT_CODE=$?

while [ $EXIT_CODE -eq 1 ]; do
  nvim \
    --listen "$SOCKET_PATH" \
    --cmd "let g:nvim_socket_path = '${SOCKET_PATH}'" \
    -c "lua require('persistence').load()" \
    "${ARGS[@]}"
  EXIT_CODE=$?
done
