#!/bin/bash

function install_rootfs() {
  echo -e "${TAG_INFO} 📦 Setting up rootfs..."
  cd rootfs || exit

  echo -e "${TAG_DEBUG} Merging parts into rootfs.tgz..."
  cat part_* > rootfs.tgz && echo -e "${TAG_SUCCESS} Parts merged successfully!${RESET}" || { echo -e "${TAG_ERROR} Failed to concatenate parts!${RESET}"; exit 1; }
  rm part_*

  if command -v ../bin/busybox pv > /dev/null; then
    echo -e "${TAG_DEBUG} Extracting rootfs with progress..."
    pv rootfs.tgz | ../bin/busybox tar zx -f - && echo -e "${TAG_SUCCESS} Extraction successful!${RESET}" || { echo -e "${TAG_ERROR} Failed to extract rootfs!${RESET}"; exit 1; }
  else
    echo -e "${TAG_DEBUG} Extracting rootfs..."
    ../bin/busybox tar zx -f rootfs.tgz && echo -e "${TAG_SUCCESS} Extraction successful!${RESET}" || { echo -e "${TAG_ERROR} Failed to extract rootfs!${RESET}"; exit 1; }
  fi

  rm rootfs.tgz
  echo -e "${TAG_SUCCESS} Rootfs setup completed!${RESET}"
  cd ..
  patch
}

function patch() {
  echo -e "${TAG_INFO} 🔧 Patching files..."

  [ -f "rootfs/usr/local/bin/lip" ] && rm rootfs/usr/local/bin/lip && echo -e "${TAG_DEBUG} Removed ${YELLOW}lip${RESET}" || echo -e "${TAG_WARN} lip does not exist. Skipping removal.${RESET}"
  [ -f "rootfs/usr/local/bin/entrypoint.sh" ] && rm rootfs/usr/local/bin/entrypoint.sh && echo -e "${TAG_DEBUG} Removed ${YELLOW}entrypoint.sh${RESET}" || echo -e "${TAG_WARN} entrypoint.sh does not exist. Skipping removal.${RESET}"

  cp patch/lip rootfs/usr/local/bin/lip && echo -e "${TAG_DEBUG} Copied ${YELLOW}lip${RESET}" || { echo -e "${TAG_ERROR} Failed to copy lip!${RESET}"; exit 1; }
  cp patch/entrypoint.sh rootfs/usr/local/bin/entrypoint.sh && echo -e "${TAG_DEBUG} Copied ${YELLOW}entrypoint.sh${RESET}" || { echo -e "${TAG_ERROR} Failed to copy entrypoint.sh!${RESET}"; exit 1; }
  cp patch/.PeEditor.exe rootfs/usr/local/bin/.PeEditor.exe && echo -e "${TAG_DEBUG} Copied ${YELLOW}.PeEditor.exe${RESET}" || { echo -e "${TAG_ERROR} Failed to copy .PeEditor.exe!${RESET}"; exit 1; }
  cp patch/.bdsdown.exe rootfs/usr/local/bin/.bdsdown.exe && echo -e "${TAG_DEBUG} Copied ${YELLOW}.bdsdown.exe${RESET}" || { echo -e "${TAG_ERROR} Failed to copy .bdsdown.exe!${RESET}"; exit 1; }

  echo -e "${TAG_SUCCESS} Patching completed!${RESET}"
}
