#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

echo "Installing packages..."

BASE_PKGS=(base-devel xorg-server xorg-xinit xorg-xrandr xorg-xinput xdg-user-dirs gcr)

WM_PKGS=(libx11 libxft libxinerama libpulse alsa-lib libxrender libxcursor)

IMG_VID_PKGS=(pcmanfm lf tumbler ffmpegthumbnailer zathura zathura-pdf-poppler gvfs mpv)

UTILITY_PKGS=(feh libnotify dunst brightnessctl cifs-utils smbclient lm_sensors polkit polkit-gnome acpi picom j4-dmenu-desktop htop fastfetch xdotool ufw libqalculate)

FILE_PKGS=(filezilla syncthing displaycal colord reflector hunspell hunspell-en_ca p7zip tar unrar unzip file-roller scrot imagemagick xclip)

THEME_PKGS=(breeze-gtk breeze5 adwaita-icon-theme adwaita-cursors)

FONT_PKGS=(woff2-font-awesome noto-fonts-emoji ttf-noto-nerd ttf-jetbrains-mono-nerd)

AUDIOSTACK_PKGS=(pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber rtkit alsa-utils pavucontrol)

DRAWING_PKGS=(inkscape gimp scribus libwacom xf86-input-wacom)

RECORDING_PKGS=(reaper reapack lsp-plugins-vst3 qpwgraph)

AUDIOCTRL_PKGS=(mpd mpc playerctl ncmpcpp)

GAMING_PKGS=(steam)

DEV_PKGS=(tmux neovim jq hugo fzf ripgrep fd nodejs npm)

VM_PKGS=(qemu-desktop libvirt edk2-ovmf virt-manager)

PRINTING_PKGS=(cups cups-pdf cups-filters system-config-printer avahi glabels)

sudo pacman -S --needed "${BASE_PKGS[@]}" || echo "WARNING: Some base packages could not be installed."

sudo pacman -S --needed "${WM_PKGS[@]}" || echo "WARNING: Some window management packages could not be installed."

sudo pacman -S --needed "${IMG_VID_PKGS[@]}" || echo "WARNING: Some image/video packages could not be installed."

sudo pacman -S --needed "${UTILITY_PKGS[@]}" || echo "WARNING: Some utility packages could not be installed."

sudo pacman -S --needed "${FILE_PKGS[@]}" || echo "WARNING: Some file packages could not be installed."

sudo pacman -S --needed "${THEME_PKGS[@]}" || echo "WARNING: Some theme packages could not be installed."

sudo pacman -S --needed "${FONT_PKGS[@]}" || echo "WARNING: Some font packages could not be installed."

sudo pacman -S --needed "${AUDIOSTACK_PKGS[@]}" || echo "WARNING: Some audio stack packages ould not be installed."

sudo pacman -S --needed "${DRAWING_PKGS[@]}" || echo "WARNING: Some drawing packages could not be installed."

sudo pacman -S --needed "${RECORDING_PKGS[@]}" || echo "WARNING: Some recording packages could not be installed."

sudo pacman -S --needed "${AUDIOCTRL_PKGS[@]}" || echo "WARNING: Some audio control packages could not be installed."

sudo pacman -S --needed "${GAMING_PKGS[@]}" || echo "WARNING: Some gaming packages could not be installed."

sudo pacman -S --needed "${DEV_PKGS[@]}" || echo "WARNING: Some web development packages could not be installed."

sudo pacman -S --needed "${VM_PKGS[@]}" || echo "WARNING: Some virtual machine packages could not be installed."

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

yay -S vcvrack-bin dymo-cups-drivers gearlever via-bin librewolf-bin

echo "Cleaning up..."
sudo pacman -Rns $(pacman -Qdtq) || echo "No orphans to remove."

echo "Adding user to kvm group for Virtual Machines..."
sudo usermod -aG kvm tristen

echo "Enabling libdirtd service for Virtual Machines..."
sudo systemctl enable libvirtd

echo "Starting virtual machine networks..."
sudo virsh net-start default
sudo virsh net-autostart default

echo "Package installation complete!"
