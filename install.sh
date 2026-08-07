#!/usr/bin/env bash

GRUB_NAME=""
GRUB_DIR=""
UPDATE_GRUB_CMD=""

function check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo -e "\e[1m\e[31mNo, You must be root!\e[0m"
    exit 1
  fi
  echo -e "\e[1m\e[32mYes, You are root!\e[0m"
}

function detect_grub() {
  if [ -d "/boot/grub2" ]; then
    GRUB_NAME="grub2"
    GRUB_DIR="/boot/grub2"
  elif [ -d "/boot/grub" ]; then
    GRUB_NAME="grub"
    GRUB_DIR="/boot/grub"
  else
    echo -e "\e[1m\e[31mGRUB directory not found!\e[0m"
    exit 1
  fi

  if command -v update-grub &> /dev/null; then
    UPDATE_GRUB_CMD="update-grub"
  elif command -v grub-mkconfig &> /dev/null; then
    UPDATE_GRUB_CMD="grub-mkconfig -o ${GRUB_DIR}/grub.cfg"
  elif command -v grub2-mkconfig &> /dev/null; then
    UPDATE_GRUB_CMD="grub2-mkconfig -o ${GRUB_DIR}/grub.cfg"
  else
    echo -e "\e[1m\e[31mGRUB update command not found!\e[0m"
    exit 1
  fi
}

function copy_papirus_files() {
  echo -e "\e[1m\e[32m==> \e[97mDownloading files...\e[0m"
  rm -rf /tmp/Papirus-Grub-Theme
  git clone --depth 1 https://github.com/osmanonurkoc/Papirus-Grub-Theme /tmp/Papirus-Grub-Theme

  echo -e "\e[1m\e[32m==> \e[97mCopying files...\e[0m"
  mkdir -p "${GRUB_DIR}/themes/"
  cp -rf /tmp/Papirus-Grub-Theme/Papirus "${GRUB_DIR}/themes/"
}

function update_grub_file() {
  grep -v GRUB_THEME < /etc/default/grub > /tmp/clean_grub
  mv /tmp/clean_grub /etc/default/grub
  echo "GRUB_THEME=\"${GRUB_DIR}/themes/Papirus/theme.txt\"" >> /etc/default/grub
}

function compile_grub() {
  echo -e "\e[1m\e[32m==> \e[97mApplying changes...\e[0m"
  eval $UPDATE_GRUB_CMD
  echo -e "\e[1m\e[34m  -> \e[97mTheme successfully applied! \e[0m"
  echo -e "\e[1m\e[34m  -> \e[97m@osmanonurkoc\e[0m"
  sleep 2
}

function main() {
  check_root
  detect_grub
  copy_papirus_files

  echo -e "\e[1m\e[97m  You must set the theme in your GRUB config file,\e[0m"

  while true; do
    read -p "  Would you like to do it now? [y/n] " answer
    case ${answer,,} in
      y|yes)
        cp /etc/default/grub /tmp/grub$(date '+%m-%d-%y_%H:%M:%S')
        update_grub_file
        compile_grub
        break
        ;;
      n|no)
        break
        ;;
      *)
        echo -e "\e[1m\e[31m  You didn't give a valid option, try again.\e[0m"
        ;;
    esac
  done
}

main "$@"
exit 0
