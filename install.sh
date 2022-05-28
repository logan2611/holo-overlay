#!/usr/bin/env bash
if [ "$EUID" != 0 ]; then
    echo -e "Please run this script as root."
    echo -e "\tEx. \"sudo $0\""
    exit 1
fi

set -xe

install -m 644 \
    "$(dirname $0)/files/etc/systemd/system/usr.mount" \
    "$(dirname $0)/files/etc/systemd/system/var-lib-pacman-local.mount" \
    "$(dirname $0)/files/etc/systemd/system/pacman-cleanup.service" \
    /etc/systemd/system/

# 99% of packages either drop their contents in /usr, and/or in already writable directories.
# If you encounter a package that does not install or work properly, please report it at
# https://github.com/logan2611/holo-overlay/issues/new?assignees=&labels=broken+package%2C+bug&template=package-does-not-work-install.md&title=
mkdir -p /opt/holo-overlay/usr/upper
mkdir /opt/holo-overlay/usr/work

# Trying not to contaminate the stock installed packages
mkdir -p /opt/holo-overlay/var/lib/pacman/local/upper
mkdir /opt/holo-overlay/var/lib/pacman/local/work

# Only starting it for now, in case something goes wrong
systemctl daemon-reload
systemctl start usr.mount
systemctl start var-lib-pacman-local.mount

pacman-key --init
pacman-key --populate archlinux --populate holo

# Probably safe to start it with everything else now
systemctl disable pacman-cleanup.service # Unfortunately useless
systemctl enable usr.mount
systemctl enable var-lib-pacman-local.mount

# Fix for missing fonts in desktop mode
pacman -Sy --needed --noconfirm lib32-fontconfig ttf-liberation
