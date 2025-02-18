#!/bin/bash

source ./levibox/colors.sh
source ./levibox/set_permissions.sh
source ./levibox/download_parts.sh
source ./levibox/install_rootfs.sh
source ./levibox/start_container.sh

echo -e "${CYAN}============================================${RESET}"
echo -e "${CYAN}           LeviBox Setup Script(Pterodactyl)            ${RESET}"
echo -e "${CYAN}============================================${RESET}"
echo -e "${GRAY}Running from directory: ${YELLOW}$(pwd)${RESET}"
echo -e "${GRAY}Date: ${YELLOW}$(date)${RESET}"
echo -e "${CYAN}============================================${RESET}"
echo -e "${TAG_INFO} Project GitHub: ${BLUE}https://github.com/dmblock/levibox${RESET}"
echo -e "${CYAN}============================================${RESET}"

cd levibox || { echo -e "${TAG_ERROR} Failed to enter levibox directory!${RESET}"; exit 1; }

set_permissions


if [ ! -d "./rootfs" ]; then
  download_parts
  install_rootfs
fi

start_container

cd ..
