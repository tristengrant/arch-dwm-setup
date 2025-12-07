#!/usr/bin/env bash
set -euo pipefail

# Root-level tasks
sudo ./root/install_packages.sh
sudo ./root/create_groups.sh
sudo ./root/enable_services.sh
sudo ./root/mount_music.sh

# User-level tasks
./user/dotfiles.sh
./user/suckless.sh
./user/dwmblocks.sh
./user/theme.sh

sudo chown -R tristen:tristen /home/tristen/*

sudo sensors-detect

echo "Setup complete! Reboot the computer."
