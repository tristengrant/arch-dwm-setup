#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

echo "Installing packages..."

BASE_PKGS=(base-devel xorg-server xorg-xinit xorg-xrandr xorg-xinput xdg-user-dirs)

WM_PKGS=(libx11 libxft libxinerama libpulse alsa-lib libxrender libxcursor)

IMG_VID_PKGS=(pcmanfm tumbler ffmpegthumbnailer zathura zathura-pdf-poppler gvfs mpv nsxiv)

UTILITY_PKGS=(feh libnotify dunst brightnessctl cifs-utils smbclient lm_sensors polkit acpi picom j4-dmenu-desktop htop fastfetch xdotool)

FILE_PKGS=(filezilla syncthing displaycal colord reflector harper hunspell hunspell-en_ca p7zip tar unrar file-roller scrot imagemagick xclip)

THEME_PKGS=(breeze-gtk breeze5 adwaita-icon-theme adwaita-cursors)

FONT_PKGS=(woff2-font-awesome noto-fonts-emoji ttf-noto-nerd ttf-jetbrains-mono-nerd)

FIREFOX_PKGS=(firefox firefox-i18n-en-ca)

QUTEBROWSER_PKGS=(qutebrowser python-adblock)

AUDIOSTACK_PKGS=(pipewire pipewire-alsa pipewire-pulse wireplumber rtkit alsa-utils pavucontrol)

DEV_PKGS=(tmux neovim jq hugo fzf)

PRINTING_PKGS=(cups cups-pdf cups-filters system-config-printer avahi)

sudo pacman -S --needed "${BASE_PKGS[@]}" || echo "WARNING: Some base packages could not be installed."

sudo pacman -S --needed "${WM_PKGS[@]}" || echo "WARNING: Some window management packages could not be installed."

sudo pacman -S --needed "${IMG_VID_PKGS[@]}" || echo "WARNING: Some image/video packages could not be installed."

sudo pacman -S --needed "${UTILITY_PKGS[@]}" || echo "WARNING: Some utility packages could not be installed."

sudo pacman -S --needed "${FILE_PKGS[@]}" || echo "WARNING: Some file packages could not be installed."

sudo pacman -S --needed "${THEME_PKGS[@]}" || echo "WARNING: Some theme packages could not be installed."

sudo pacman -S --needed "${FONT_PKGS[@]}" || echo "WARNING: Some font packages could not be installed."

sudo pacman -S --needed "${FIREFOX_PKGS[@]}" || echo "WARNING: Some firefox packages could not be installed."

sudo pacman -S --needed "${QUTEBROWSER_PKGS[@]}" || echo "WARNING: Some qutebrowser packages could not be installed."

sudo pacman -S --needed "${AUDIOSTACK_PKGS[@]}" || echo "WARNING: Some audio stack packages ould not be installed."

sudo pacman -S --needed "${DEV_PKGS[@]}" || echo "WARNING: Some web development packages could not be installed."

sudo pacman -S --needed "${PRINTING_PKGS[@]}" || echo "WARNING: Some printing packages could not be installed."

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

paru -S gearlever

echo "Cleaning up..."
sudo pacman -Rns $(pacman -Qdtq) || echo "No orphans to remove."

echo "Package installation complete!"
