#!/bin/bash

function start_container() {
  echo -e "${TAG_INFO} 🚀 Starting container..."
  CWD=$(pwd)
  bin/proot \
    -0 \
    -r $CWD/rootfs \
    -b /proc:/proc \
    -b ../:/root \
    /usr/bin/env \
    -i PATH=$PATH:/usr/local/bin \
    HOME=/root \
    XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    WINEDEBUG=-all \
    EULA=TRUE \
    GITHUB_MIRROR_URL=https://github.bibk.top \
    GO_MODULE_PROXY_URL=https://goproxy.cn \
    LANG=zh_CN.UTF-8 \
    /usr/local/bin/entrypoint.sh || { echo -e "${TAG_ERROR} Failed to start container!${RESET}"; exit 1; }

  echo -e "${TAG_SUCCESS} Container stopped successfully!${RESET}"
  exit 0
}
