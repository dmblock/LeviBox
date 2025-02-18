#!/bin/bash

function set_permissions() {
  echo -e "${TAG_INFO} 🔧 Setting permissions..."

  if [ -d "rootfs/usr/local/bin" ]; then
    echo -e "${TAG_DEBUG} Setting permissions for ${YELLOW}rootfs/usr/local/bin${RESET}"
    chmod +x rootfs/usr/local/bin -R && echo -e "${TAG_SUCCESS} Permissions set successfully!${RESET}" || { echo -e "${TAG_ERROR} Failed to set permissions for rootfs/usr/local/bin!${RESET}"; exit 1; }
  else
    echo -e "${TAG_WARN} Directory rootfs/usr/local/bin does not exist. Skipping permissions.${RESET}"
  fi

  if [ -d "bin" ]; then
    echo -e "${TAG_DEBUG} Setting permissions for ${YELLOW}bin${RESET}"
    chmod +x bin -R && echo -e "${TAG_SUCCESS} Permissions set successfully!${RESET}" || { echo -e "${TAG_ERROR} Failed to set permissions for bin!${RESET}"; exit 1; }
  else
    echo -e "${TAG_WARN} Directory bin does not exist. Skipping permissions.${RESET}"
  fi

  echo -e "${TAG_SUCCESS} All permissions set successfully!${RESET}"
}
