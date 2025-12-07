#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

echo "Installing packages..."

sudo pacman -S --needed --noconfirm --ask 4 base-devel linux-zen linux-zen-headers libx11 libxft libxinerama libpulse alsa-lib libxrender libxcursor xorg-server xorg-xinit xorg-xrandr xorg-xinput pcmanfm syncthing xclip xdotool feh dunst breeze-gtk breeze5 adwaita-icon-theme adwaita-cursors picom woff2-font-awesome noto-fonts-emoji ttf-noto-nerd ttf-jetbrains-mono-nerd libnotify brightnessctl networkmanager nm-applet cifs-utils smbclient lm_sensors jq zstd p7zip tar unrar file-roller scrot imagemagick htop tumbler ffmpegthumbnailer polkit acpi hugo fastfetch firefox firefox-i18n-en-ca qutebrowser python-adblock harper hunspell hunspell-en_ca filezilla displaycal colord fzf reflector j4-dmenu-desktop xdg-user-dirs gvfs bitwarden

sudo pacman -S --needed --noconfirm --ask 4 pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber rtkit alsa-utils pavucontrol

sudo pacman -S --needed --noconfirm --ask 4 inkscape gimp scribus zathura zathura-pdf-poppler reaper reapack lsp-plugins-vst3 qpwgraph libwacom xf86-input-wacom
 
sudo pacman -S --needed --noconfirm --ask 4 mpd mpc playerctl ncmpcpp mpv nsxiv

sudo pacman -S --needed --noconfirm --ask 4 steam

sudo pacman -S --needed --noconfirm --ask 4 tmux neovim

sudo pacman -S --needed --noconfirm --ask 4 cups cups-pdf cups-filters system-config-printer avahi glabels

echo "Refreshing font cache..."
fc-cache -fv

echo "Installing Paru AUR helper..."
mkdir -p /home/tristen/Downloads
cd /home/tristen/Downloads
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd /home/tristen/Downloads
rm -rf paru

paru -S vcvrack-bin dymo-cups-drivers gearlever

echo "Cleaning up..."
sudo pacman -Rns $(pacman -Qdtq) || echo "No orphans to remove."

echo "Package installation complete!"
