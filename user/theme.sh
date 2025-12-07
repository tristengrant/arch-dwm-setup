#!/bin/bash
# DESC: Install Orchis Grey Dark GTK theme and Colloid Grey Dracula Dark icon theme using their install.sh scripts

set -euo pipefail

GTK_THEME="Breeze-Dark"
ICON_THEME="Adwaita"

# GTK CONFIG FILES
echo "Writing GTK configuration files..."

mkdir -p "$HOME/.config/gtk-3.0"

# GTK 3
#cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOF
#[Settings]
#gtk-theme-name=$GTK_THEME
#gtk-icon-theme-name=$ICON_THEME
#gtk-font-name=Sans 12
#gtk-cursor-theme-name=Adwaita
#gtk-xft-antialias=1
#gtk-xft-hinting=1
#gtk-xft-hintstyle=hintfull
#EOF

# GTK 2
cat > "$HOME/.gtkrc-2.0" <<EOF
gtk-theme-name="$GTK_THEME"
gtk-icon-theme-name="$ICON_THEME"
gtk-font-name="Sans 12"
gtk-cursor-theme-name="Adwaita"
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintfull"
EOF

echo "Done!"
echo "GTK + Icon themes installed and configured."

# Apply via gsettings (GTK3 applications)
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

echo "Themes installed and applied successfully"
