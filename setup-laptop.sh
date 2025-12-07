#!/usr/bin/env bash

# Root-level tasks
./root/laptop-install-packages.sh
sudo ./root/create-groups.sh
sudo ./root/enable-services.sh

# User-level tasks
./user/dotfiles.sh
./user/suckless.sh
./user/laptop-dwmblocks.sh
./user/theme.sh

sudo chown -R tristen:tristen /home/tristen/*

sudo sensors-detect

systemctl enable colord.service

echo "Setup complete! Reboot the computer."
