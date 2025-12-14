#!/usr/bin/env bash
set -euo pipefail

USER="tristen"
GROUPS=(video audio input lp)

# Create groups if they don't exist
for grp in "${GROUPS[@]}"; do
    if ! getent group "$grp" >/dev/null; then
        echo "Creating group $grp..."
        groupadd "$grp"
    fi
done

# Add user to groups
echo "Adding $USER to groups..."
usermod -aG "${GROUPS[*]}" "$USER"

# Configure real-time audio limits for pro-audio applications
LIMITS_FILE="/etc/security/limits.d/99-realtime.conf"
if [ ! -f "$LIMITS_FILE" ]; then
    echo "Creating $LIMITS_FILE to configure real-time audio limits..."
    cat <<EOF > "$LIMITS_FILE"
# Real-time audio permissions for JACK / VCV Rack / Reaper
@audio   -  rtprio     95
@audio   -  memlock    unlimited
@audio   -  nice      -10
EOF
    echo "Real-time limits configured in $LIMITS_FILE."
else
    echo "$LIMITS_FILE already exists. Skipping."
fi

# Configure systemd user slice for real-time audio
SYSTEMD_DIR="/etc/systemd/user/user.slice.d"
SYSTEMD_FILE="$SYSTEMD_DIR/50-realtime.conf"
if [ ! -f "$SYSTEMD_FILE" ]; then
    echo "Creating $SYSTEMD_FILE to apply real-time limits to user services..."
    sudo mkdir -p "$SYSTEMD_DIR"
    cat <<EOF | sudo tee "$SYSTEMD_FILE" >/dev/null
[Slice]
# Real-time audio limits for user services
CPUAccounting=yes
IOAccounting=yes
LimitRTPRIO=infinity
LimitMEMLOCK=infinity
Nice=-10
EOF
    echo "Systemd user slice configured for real-time audio."
else
    echo "$SYSTEMD_FILE already exists. Skipping."
fi

# Enable lingering so user services start even without login
echo "Enabling user lingering for $USER..."
loginctl enable-linger "$USER"

echo ""
echo "Done!"
echo "IMPORTANT: Log out and back in to activate new groups."
echo "Your real-time audio limits are active; PipeWire/JACK services will now honor them even when started via systemctl --user."
