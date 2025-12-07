#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

echo "Installing essential system packages..."

BASE_PKGS=(base-devel linux-zen linux-zen-headers libx11 libxft libxinerama libpulse alsa-lib libxrender libxcursor xorg-server xorg-xinit xorg-xrandr xorg-xinput mesa xf86-video-intel pcmanfm syncthing xclip xdotool feh dunst breeze-gtk breeze5 adwaita-icon-theme adwaita-cursors picom woff2-font-awesome noto-fonts-emoji ttf-noto-nerd ttf-jetbrains-mono-nerd libnotify brightnessctl networkmanager nm-applet cifs-utils smbclient lm_sensors jq zstd 7zip tar unrar file-roller scrot imagemagick htop tumbler ffmpegthumbnailer kimageformats polkit acpi hugo fastfetch firefox firefox-i18n-en-ca qutebrowser python-adblock harper hunspell hunspell-en_ca filezilla displaycal colord fzf reflector j4-dmenu-desktop xdg-user-dirs gvfs)

AUDIO_STACK=(pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber rtkit alsa-utils pavucontrol)

CREATIVE_APPS=(darktable inkscape gimp scribus zathura zathura-pdf-poppler reaper sws reapack lsp-plugins-vst3 qpwgraph libwacom xf86-input-wacom)
 
MEDIA_APPS=(mpd mpc playerctl ncmpcpp mpv steam nsxiv)

DEV_APPS=(tmux neovim)

PRINTING=(cups cups-pdf cups-filters system-config-printer avahi glabels)

sudo pacman -S "${BASE_PKGS[@]}" || echo "WARNING: Some base packages could not be installed."

sudo pacman -S "${AUDIO_STACK[@]}" || echo "WARNING: Some audio packages could not be installed."

sudo pacman -S "${CREATIVE_APPS[@]}" || echo "WARNING: Some creative packages could not be installed."

sudo pacman -S "${MEDIA_APPS[@]}" || echo "WARNING: Some media packages could not be installed."

sudo pacman -S "${DEV_APPS[@]}" || echo "WARNING: Some dev packages could not be installed."

sudo pacman -S "${PRINTING[@]}" || echo "WARNING: Some printing packages could not be installed."

echo "Refreshing font cache..."
fc-cache -fv

echo "Installing Paru AUR helper..."
mkdir -p /home/tristen/Downloads
cd /home/tristen/Downloads
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd /home/tristen//Downloads
rm -rf paru

paru -S vcvrack-bin dymo-cups-drivers gearlever jellyfin-media-player

echo "Cleaning up..."
sudo pacman -Rns $(pacman -Qdtq) || echo "No orphans to remove."

echo "Package installation complete!"
