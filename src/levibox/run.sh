#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GRAY='\033[0;37m'
RESET='\033[0m'

cd levibox

function setPerm() {
  chmod +x bin -R
}

function downloadParts() {
  mkdir -p rootfs || { echo -e "${RED}Failed to create rootfs directory!${RESET}"; exit 1; }
  cd rootfs || exit

  files=(
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_aa"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ab"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ac"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ad"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ae"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_af"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ag"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ah"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ai"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_aj"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ak"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_al"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_am"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_an"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ao"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ap"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_aq"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ar"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_as"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_at"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_au"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_av"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_aw"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ax"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ay"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_az"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_ba"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bb"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bc"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bd"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_be"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bf"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bg"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bh"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bi"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bj"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bk"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bl"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bm"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bn"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bo"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bp"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bq"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_br"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bs"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bt"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bu"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bv"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bw"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_bx"
    "https://github.bibk.top/dmblock/levibox/raw/main/image/part_by"
  )

  total_files=${#files[@]}
  downloaded_files=0

  for url in "${files[@]}"; do
      filename=$(basename "$url")
      echo -e "(${GREEN}Downloading: ${YELLOW}${filename}${RESET})"

      if wget -q "$url" -O "$filename"; then
          downloaded_files=$((downloaded_files + 1))
          echo -e "${GREEN}Download Success: ${YELLOW}${filename} ${GREEN}✅${RESET}"
      else
          echo -e "${RED}Download Failed: ${YELLOW}${filename}${RESET}"
      fi

      showProgress $downloaded_files $total_files
  done

  echo -e "\n${BLUE}All downloads completed!${RESET}"
  cd ..
}

function showProgress() {
  local downloaded_files=$1
  local total_files=$2
  progress=$((downloaded_files * 100 / total_files))
  bar_length=30
  filled_length=$((progress * bar_length / 100))
  empty_length=$((bar_length - filled_length))

  bar=$(printf "%-${filled_length}s" " " | tr ' ' '=')
  empty=$(printf "%-${empty_length}s" " " | tr ' ' '=')

  printf "\r${CYAN}Collecting: [${PURPLE}${bar}${RESET}${GRAY}${empty}${RESET}${CYAN}] ${RESET}${progress}%%"
}

function patch() {
  rm rootfs/usr/local/bin/lip
  rm rootfs/usr/local/bin/entrypoint.sh
  cp patch/lip rootfs/usr/local/bin/lip
  cp patch/entrypoint.sh rootfs/usr/local/bin/entrypoint.sh
  cp patch/.PeEditor.exe rootfs/usr/local/bin/.PeEditor.exe
  cp patch/.bdsdown.exe rootfs/usr/local/bin/.bdsdown.exe
}

function installRootFS() {
  echo -e "${CYAN}Setting up rootfs..."
  cd rootfs || exit
  cat part_* > rootfs.tgz
  rm part_*
  ../bin/busybox tar zxvf rootfs.tgz || { echo -e "${RED}Failed to extract rootfs!${RESET}"; exit 1; }
  rm rootfs.tgz
  echo -e "${GREEN}Done!"
  cd ..
  patch
}

function startContainer() {
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
  /usr/local/bin/entrypoint.sh

  exit 0
}

setPerm


if [ ! -d "./rootfs" ]; then
  downloadParts
  installRootFS
fi

startContainer
cd ..
