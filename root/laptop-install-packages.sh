#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

echo "Installing packages..."

BASE_PKGS=(base-devel xorg-server xorg-xinit xorg-xrandr xorg-xinput xdg-user-dirs)

WM_PKGS=(libx11 libxft libxinerama libpulse alsa-lib libxrender libxcursor)

IMG_VID_PKGS=(pcmanfm lf tumbler ffmpegthumbnailer zathura zathura-pdf-poppler gvfs mpv nsxiv)

UTILITY_PKGS=(feh libnotify dunst brightnessctl cifs-utils smbclient lm_sensors polkit polkit-gnome acpi picom j4-dmenu-desktop htop fastfetch xdotool ufw)

FILE_PKGS=(filezilla syncthing colord reflector harper hunspell hunspell-en_ca p7zip tar unrar file-roller scrot imagemagick xclip)

THEME_PKGS=(breeze-gtk breeze5 adwaita-icon-theme adwaita-cursors)

FONT_PKGS=(woff2-font-awesome noto-fonts-emoji ttf-noto-nerd ttf-jetbrains-mono-nerd)

FIREFOX_PKGS=(firefox firefox-i18n-en-ca)

AUDIOSTACK_PKGS=(pipewire pipewire-alsa pipewire-pulse wireplumber rtkit alsa-utils pavucontrol)

DEV_PKGS=(tmux neovim jq hugo fzf ripgrep fd nodejs npm)

PRINTING_PKGS=(cups cups-pdf cups-filters system-config-printer avahi)

sudo pacman -S --needed "${BASE_PKGS[@]}" || echo "WARNING: Some base packages could not be installed."

sudo pacman -S --needed "${WM_PKGS[@]}" || echo "WARNING: Some window management packages could not be installed."

sudo pacman -S --needed "${IMG_VID_PKGS[@]}" || echo "WARNING: Some image/video packages could not be installed."

sudo pacman -S --needed "${UTILITY_PKGS[@]}" || echo "WARNING: Some utility packages could not be installed."

sudo pacman -S --needed "${FILE_PKGS[@]}" || echo "WARNING: Some file packages could not be installed."

sudo pacman -S --needed "${THEME_PKGS[@]}" || echo "WARNING: Some theme packages could not be installed."

sudo pacman -S --needed "${FONT_PKGS[@]}" || echo "WARNING: Some font packages could not be installed."

sudo pacman -S --needed "${FIREFOX_PKGS[@]}" || echo "WARNING: Some firefox packages could not be installed."

sudo pacman -S --needed "${AUDIOSTACK_PKGS[@]}" || echo "WARNING: Some audio stack packages ould not be installed."

sudo pacman -S --needed "${DEV_PKGS[@]}" || echo "WARNING: Some web development packages could not be installed."

sudo pacman -S --needed "${PRINTING_PKGS[@]}" || echo "WARNING: Some printing packages could not be installed."

echo "Refreshing font cache..."
fc-cache -fv

echo "Installing Yay AUR helper..."
mkdir -p /home/tristen/Downloads
cd /home/tristen/Downloads
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /home/tristen/Downloads
rm -rf yay
rm -rf ~/go

yay -S gearlever kanata-bin

echo "Cleaning up..."
sudo pacman -Rns $(pacman -Qdtq) || echo "No orphans to remove."

# Setting up Kanata for keyboard remapping on Laptop
sudo groupadd --system uinput
sudo groupdel uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
mkdir -p /etc/udev/rules.d/

# Writing udev rules for Kanata
sudo cat <<EOF >"etc/udev/rules.d/99-input.rules"
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF

# Reload udev rules
sudo udevadm control --reload-rules && sudo udevadm trigger

echo "Package installation complete!"
