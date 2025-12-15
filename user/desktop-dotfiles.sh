#!/usr/bin/env bash
set -euo pipefail

USER="tristen"
HOME_DIR="/home/$USER"

mkdir -p "$HOME_DIR/.config"

cat >"$HOME_DIR/.config/user-dirs.dirs" <<'EOF'
XDG_DESKTOP_DIR="/home/tristen"
XDG_DOCUMENTS_DIR="/home/tristen/Documents"
XDG_DOWNLOAD_DIR="/home/tristen/Downloads"
XDG_MUSIC_DIR="/home/tristen/Music"
XDG_PICTURES_DIR="/home/tristen/Pictures"
XDG_VIDEOS_DIR="/home/tristen/Videos"
XDG_TEMPLATES_DIR="/home/tristen/"
XDG_PUBLICSHARE_DIR="/home/tristen/"
EOF

echo "Making home directories..."
mkdir -p "$HOME_DIR/Documents"
mkdir -p "$HOME_DIR/Documents/notes"
mkdir -p "$HOME_DIR/Downloads"
mkdir -p "$HOME_DIR/Music"
mkdir -p "$HOME_DIR/Pictures"
mkdir -p "$HOME_DIR/Pictures/screenshots"
mkdir -p "$HOME_DIR/Videos"
mkdir -p "$HOME_DIR/Projects"
mkdir -p "$HOME_DIR/Applications"
mkdir -p "$HOME_DIR/.local/bin"
mkdir -p "$HOME_DIR/.local/share/applications"
mkdir -p "$HOME_DIR/.local/state"

echo "Cloning and symlinking dotfiles..."
cd "$HOME_DIR/Projects"
[ -d "$HOME_DIR/Projects/dotfiles" ] || git clone https://github.com/tristengrant/dotfiles.git

# In .config
ln -sf "$HOME_DIR/Projects/dotfiles/config/mpv" "$HOME_DIR/.config/mpv"
ln -sf "$HOME_DIR/Projects/dotfiles/config/mpd" "$HOME_DIR/.config/mpd"
ln -sf "$HOME_DIR/Projects/dotfiles/config/dunst" "$HOME_DIR/.config/dunst"
ln -sf "$HOME_DIR/Projects/dotfiles/config/picom" "$HOME_DIR/.config/picom"
ln -sf "$HOME_DIR/Projects/dotfiles/config/nvim" "$HOME_DIR/.config/nvim"
ln -sf "$HOME_DIR/Projects/dotfiles/config/tmux" "$HOME_DIR/.config/tmux"
ln -sf "$HOME_DIR/Projects/dotfiles/config/nsxiv" "$HOME_DIR/.config/nsxiv"

# In home directory
ln -sf "$HOME_DIR/Projects/dotfiles/desktop_dot_xinitrc" "$HOME_DIR/.xinitrc"
ln -sf "$HOME_DIR/Projects/dotfiles/dot_bashrc" "$HOME_DIR/.bashrc"
ln -sf "$HOME_DIR/Projects/dotfiles/dot_bash_profile" "$HOME_DIR/.bash_profile"
ln -sf "$HOME_DIR/Projects/dotfiles/dot_xprofile" "$HOME_DIR/.xprofile"

# In .local/share/applications
ln -sf "$HOME_DIR/Projects/dotfiles/local/share/application/nsxiv.desktop" "$HOME_DIR/.local/share/applications/nsxiv.desktop"
ln -sf "$HOME_DIR/Projects/dotfiles/local/share/applications/neovim.desktop" "$HOME_DIR/.local/share/applications/neovim.desktop"

# Telekasten NeoVim Plugin Templates
ln -sf "$HOME_DIR/Projects/dotfiles/telekasten-nvim/templates" "$HOME_DIR/Documents/notes"

source /home/tristen/.bashrc

echo "Cloning scripts repo..."
cd "$HOME_DIR/Projects"
[ -d "$HOME_DIR/Projects/scripts" ] || git clone https://github.com/tristengrant/scripts.git

chmod +x /home/tristen/.xinitrc
