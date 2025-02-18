#!/bin/bash

function download_parts() {
  echo -e "${TAG_INFO} 📥 Downloading parts..."
  mkdir -p rootfs || { echo -e "${TAG_ERROR} Failed to create rootfs directory!${RESET}"; exit 1; }
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
    echo -e "\n${TAG_DEBUG} Downloading: ${YELLOW}${filename}${RESET}"

    if ../bin/busybox wget -q "$url" -O "$filename"; then
      downloaded_files=$((downloaded_files + 1))
      echo -e "${TAG_SUCCESS} Download Success: ${YELLOW}${filename}${RESET}"
    else
      echo -e "${TAG_ERROR} Download Failed: ${YELLOW}${filename}${RESET}"
      exit 1
    fi

    show_progress $downloaded_files $total_files
  done

  echo -e "\n${TAG_SUCCESS} All downloads completed!${RESET}"
  cd ..
}

function show_progress() {
  local downloaded_files=$1
  local total_files=$2
  progress=$((downloaded_files * 100 / total_files))
  bar_length=30
  filled_length=$((progress * bar_length / 100))
  empty_length=$((bar_length - filled_length))

  bar=$(printf "%-${filled_length}s" " " | tr ' ' '=')
  empty=$(printf "%-${empty_length}s" " " | tr ' ' ' ')

  printf "\r${TAG_DEBUG} 📦 Progress: [${PURPLE}${bar}${RESET}${GRAY}${empty}${RESET}${CYAN}] ${RESET}${progress}%%  "
  printf "\033[K"
}
