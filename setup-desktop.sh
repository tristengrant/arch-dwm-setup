#!/usr/bin/env bash

# Root-level tasks
./root/desktop-install-packages.sh
sudo ./root/create-groups.sh
sudo ./root/enable-services.sh
sudo ./root/mount-music.sh

# User-level tasks
./user/desktop-dotfiles.sh
./user/suckless.sh
./user/desktop-dwmblocks.sh

sudo chown -R tristen:tristen /home/tristen/*

sudo sensors-detect

systemctl enable colord.service

echo "Setup complete! Reboot the computer."
