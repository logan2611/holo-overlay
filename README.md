# Holo-Overlay

A small collection of systemd services and scripts to enable installing packages on SteamOS 3.x

Holo-Overlay persists through updates without the use of RAUC, allowing you to install it alongside other modification that utilize it to persist.

**This is experimental software, it could potentially brick your system or otherwise degrade it's usability. Do not install unless you are prepared to recover from such an occurrence.**

## Installation:
1. Clone the repo
2. Run install.sh as root
```
cd /tmp
git clone https://github.com/logan2611/holo-overlay.git
cd holo-overlay
sudo ./install.sh
```

## Uninstallation:
(This hasn't been tested yet)
```
sudo systemctl disable usr.mount var-lib-pacman-local.mount
sudo rm -r /etc/systemd/system/usr.mount /etc/systemd/system/var-lib-pacman-local.mount /etc/systemd/system/pacman-cleanup.service /opt/holo-overlay/
sudo reboot
```
